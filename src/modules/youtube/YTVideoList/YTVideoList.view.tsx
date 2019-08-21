import React from 'react'

import { View, FlatList, ListRenderItemInfo } from 'react-native'
import { YTVideoListViewStyles } from './styles';
import YTVideoItem from './YTVideo.view';

const YTVideoListView: React.FC = (props) => {

    const NUMBER_COLUMN: number = 2

    const keyExtractor = (item: number) => "test" + item
    const renderItem = ({ item }: ListRenderItemInfo<number>) => {
        return (
            <YTVideoItem

            />
        )
    }
    const ItemSeparatorComponent = () => <View style={{ marginTop: 15 }} />
    return (
        <View style={YTVideoListViewStyles.container}>
            <FlatList<number>
                style={YTVideoListViewStyles.list}
                ItemSeparatorComponent={ItemSeparatorComponent}
                numColumns={NUMBER_COLUMN}
                data={[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]}
                keyExtractor={keyExtractor}
                renderItem={renderItem}
            />
        </View>
    )
}

export default YTVideoListView
