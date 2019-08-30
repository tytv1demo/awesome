import { AppRegistry } from 'react-native'
import {
  YTVideoListView,
  TWIVideoView, ZingMp3View
} from './src/modules'

export default function registerComponent() {
  AppRegistry.registerComponent("YTVideoList", () => YTVideoListView)
  AppRegistry.registerComponent("TWIVideo", () => TWIVideoView)
  AppRegistry.registerComponent("ZingMp3", () => ZingMp3View)
  
}