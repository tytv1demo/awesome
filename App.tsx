import { AppRegistry } from 'react-native'
import {
  YTVideoListView
} from './src/modules'

export default function registerComponent() {
  AppRegistry.registerComponent("YTVideoList", () => YTVideoListView)
}