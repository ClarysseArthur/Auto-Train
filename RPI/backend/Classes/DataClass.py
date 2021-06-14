from .Database import Database


class DataRepository:
    @staticmethod
    def json_or_formdata(request):
        if request.content_type == 'application/json':
            gegevens = request.get_json()
        else:
            gegevens = request.form.to_dict()
        return gegevens

    @staticmethod
    def insert_rit_start(start, aankomst, spoor = 1):
        sql = "INSERT INTO tblRitten(Starttijd, VerwachteAankomst, SpoorID) VALUES (%s, %s, %s);"
        params = [start, aankomst, spoor]
        Database.execute_sql(sql, params)

        sql = "SELECT RitID FROM TreinDB.tblRitten WHERE Starttijd = %s;"
        params = [start]
        return Database.get_one_row(sql, params)['RitID']

    @staticmethod
    def insert_rit_stop_delay(stop, type, id):
        sql = "UPDATE tblRitten SET EchteAankomst = %s, VertragingTypeID = %s WHERE RitID = %s;"
        params = [stop, type, id]
        return Database.execute_sql(sql, params)

    @staticmethod
    def insert_rit_stop(stop, id):
        sql = "UPDATE tblRitten SET EchteAankomst = %s WHERE RitID = %s;"
        params = [stop, id]
        Database.execute_sql(sql, params)