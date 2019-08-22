import React from 'react'
import { TouchableOpacity, Text, View, FlatList, ListRenderItemInfo } from 'react-native'

import { TWIChatChannelListStyles } from './styles';

interface TWIChatChannelListState {

}

class TWIChatChannelList extends React.PureComponent<any, TWIChatChannelListState> {


    constructor(props: any) {
        super(props);
        this.state = {

        }
    }

    keyExtractor = (item: number) => "test" + item
    renderItem = ({ item }: ListRenderItemInfo<number>) => {
        return (
            <View

            />
        )
    }
    ItemSeparatorComponent = () => <View style={{ marginTop: 15 }} />
    render() {
        const { } = this.state
        return (
            <View style={TWIChatChannelListStyles.container} >
                <FlatList<number>
                    style={TWIChatChannelListStyles.list}
                    ItemSeparatorComponent={this.ItemSeparatorComponent}
                    data={[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]}
                    keyExtractor={this.keyExtractor}
                    renderItem={this.renderItem}
                />ƒ
            </View >
        )
    }
}

export default TWIChatChannelList
