from flask import Flask, request, jsonify
import pandas as pd

app = Flask(__name__)

@app.route('/search_area', methods=['POST'])
def search_area():
    # Receive the JSON data from the Flutter app
    data = request.json
    print(data)  # Print the received data for debugging
    
    # Safely get the 'Area' value from the data
    area_value = data.get('Area')
    if area_value is None:
        return jsonify({'error': 'Area key is missing from the request'}), 400
    
    # Load the Excel file
    df = pd.read_excel('C:/Users/user/OneDrive/Desktop/floorplan.xlsx')
    
    # Search for rows where the area is less than or equal to the received area value
    matching_rows = df[df['Area'] <= area_value]
    
    # Get the list of image names from the 'items_num' column
    image_names = matching_rows['items_num'].tolist()
    
    # Return the list of image names
    return jsonify(image_names)

if __name__ == '__main__':
    # app.run(debug=True) #for emulator
     app.run(host='0.0.0.0',port=8000,debug=True)  #for real device 
