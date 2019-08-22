import { AppRegistry } from 'react-native'
import {
  YTVideoListView,
  TWIVideoView
} from './src/modules'

export default function registerComponent() {
  AppRegistry.registerComponent("YTVideoList", () => YTVideoListView)
  AppRegistry.registerComponent("TWIVideo", () => TWIVideoView)
}