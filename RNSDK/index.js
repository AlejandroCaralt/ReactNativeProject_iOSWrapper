import React from 'react';
import { AppRegistry, Text, TouchableOpacity, StyleSheet, View } from 'react-native';

const BlueButtonComponent = (props) => {
    return (
        <View style={styles.container}>
            <TouchableOpacity style={styles.button} onPress={() => console.log('Button tapped - React Native')}>
                <Text style={styles.text}>{props.title || 'RN Button'}</Text>
            </TouchableOpacity>
        </View>
    );
};

const styles = StyleSheet.create({
    container: { flex: 1, justifyContent: 'center', alignItems: 'center' },
    button: { backgroundColor: '#007AFF', padding: 15, borderRadius: 10 },
    text: { color: 'white', fontSize: 18, fontWeight: 'bold' }
});

AppRegistry.registerComponent('BlueButtonComponent', () => BlueButtonComponent);
