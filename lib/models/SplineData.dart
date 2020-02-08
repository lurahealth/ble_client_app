class SplineData{
  double dataReading;
  DateTime timeStamp;

  SplineData(this.dataReading, this.timeStamp);

  factory SplineData.fromLiveData(DateTime timeStamp, double dataReading){
    return SplineData(dataReading, timeStamp);
  }

  factory SplineData.fromDatabase(int timeInMillSeconds, double dataReading){
    return SplineData(dataReading,
                      DateTime.fromMillisecondsSinceEpoch(timeInMillSeconds));
  }
}