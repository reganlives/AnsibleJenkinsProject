from flask import Flask
from flask import render_template, request

app = Flask(__name__)

def findPositive(number):
    posneg = ''
    if number != 0:
        if number < 0:
            posneg = 'negative number'
        else:
            posneg = 'positive number'
        return posneg
    else:
        return number

@app.route('/', methods=['GET', 'POST'])
def index():
    return render_template('index.html')

@app.route('/result', methods=['GET', 'POST'])

def result():
    myformData = request.form.get('number')
    myformData = int(myformData)
    res = findPositive(myformData)
    return render_template('result.html', result=res, myformData=myformData)
if __name__ == "__main__":
    app.run(host='0.0.0.0', port='5000', debug=True)