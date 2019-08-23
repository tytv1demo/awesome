import { NativeModules } from 'react-native'

const Bridge = NativeModules.YTVideoListManager

class YTVideoListBridge {
    static pushToDetail(): void {
        return Bridge.pushToDetail()
    }
}
export default YTVideoListBridge