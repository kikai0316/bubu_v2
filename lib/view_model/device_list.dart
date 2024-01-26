import 'dart:async';
import 'package:bubu_v2/view_model/all_users.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'device_list.g.dart';

NearbyService? nearbyService;
StreamSubscription<dynamic>? stateChangedSubscription;

@Riverpod(keepAlive: true)
class DeviceListNotifier extends _$DeviceListNotifier {
  @override
  Future<List<String>?> build() async {
    return null;
  }

  Future<void> initNearbyService(String myId) async {
    nearbyService = NearbyService();
    await nearbyService?.init(
      serviceType: 'bubu',
      deviceName: myId,
      strategy: Strategy.P2P_CLUSTER,
      callback: (bool isRunning) async {
        if (isRunning) {
          try {
            await nearbyService?.stopAdvertisingPeer();
            await nearbyService?.stopBrowsingForPeers();
            await stateChangedSubscription?.cancel();
            await Future<void>.delayed(const Duration(microseconds: 200));
            await nearbyService?.startAdvertisingPeer();
            await nearbyService?.startBrowsingForPeers();
            await Future<void>.delayed(const Duration(microseconds: 200));
            callbackNearbyService();
            state = await AsyncValue.guard(() async {
              return [];
            });
          } catch (e) {
            await nearbyService?.stopAdvertisingPeer();
            await nearbyService?.stopBrowsingForPeers();
            state = await AsyncValue.guard(() async {
              return null;
            });
            return;
          }
        }
      },
    );
  }

  Future<void> callbackNearbyService() async {
    final allUsersNotifier = ref.read(allUsersNotifierProvider.notifier);
    stateChangedSubscription = nearbyService?.stateChangedSubscription(
      callback: (devicesList) async {
        state = await AsyncValue.guard(() async {
          final deviceIds = devicesList.map((e) => e.deviceId).toList();
          for (final device in devicesList) {
            if (!deviceIds.contains(device.deviceId)) {
              allUsersNotifier.addData(device.deviceId);
            }
          }
          return devicesList.map((e) => e.deviceId).toList();
        });
      },
    );
  }

  Future<void> cancelNearbyService() async {
    await nearbyService?.stopAdvertisingPeer();
    await nearbyService?.stopBrowsingForPeers();
    await stateChangedSubscription?.cancel();
    state = await AsyncValue.guard(() async {
      return null;
    });
  }
}
