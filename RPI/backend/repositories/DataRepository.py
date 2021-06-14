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
    def read_ritten(delay):
        sql = "SELECT RitID, Starttijd, TIME_TO_SEC(TIMEDIFF(EchteAankomst, VerwachteAankomst)) as 'Vertraging' FROM tblRitten HAVING Vertraging >= %s;"
        params = [delay]
        return Database.get_rows(sql, params)

    @staticmethod
    def read_vertraging_minuten(dalay):
        sql = "SELECT TIME_TO_SEC(TIMEDIFF(EchteAankomst, VerwachteAankomst)) AS `Vertraging` FROM TreinDB.tblRitten GROUP BY Vertraging HAVING Vertraging >= %s ORDER BY Vertraging;"
        params = [dalay]
        return Database.get_rows(sql, params)

    @staticmethod
    def read_vertraging_day(datum):
        sql = "SELECT TIME_TO_SEC(TIMEDIFF(EchteAankomst, VerwachteAankomst)) AS `Vertraging` FROM TreinDB.tblRitten WHERE DATE(Starttijd) = %s GROUP BY Vertraging HAVING Vertraging > 0 ORDER BY Vertraging;"
        params = [datum]
        return Database.get_rows(sql, params)

    @staticmethod
    def read_dates():
        sql = "SELECT date(Starttijd) AS 'Datum' FROM TreinDB.tblRitten GROUP BY date(starttijd);"
        return Database.get_rows(sql)

    @staticmethod
    def sort_dates_vertraging(datum, vertraging):
        sql = "SELECT RitID, Starttijd, CONVERT(CONVERT(TIMEDIFF(EchteAankomst, VerwachteAankomst), SIGNED) / 100, SIGNED) AS `Vertraging` FROM TreinDB.tblRitten WHERE date(Starttijd) = %s HAVING Vertraging > %s;"
        params = [datum, vertraging]
        return Database.get_rows(sql, params)

    @staticmethod
    def sort_dates(datum):
        sql = "SELECT RitID, Starttijd, TIME_TO_SEC(TIMEDIFF(EchteAankomst, VerwachteAankomst)) AS `Vertraging` FROM TreinDB.tblRitten WHERE date(Starttijd) = %s HAVING Vertraging >= 0 Order By Starttijd;"
        params = [datum]
        return Database.get_rows(sql, params)

    @staticmethod
    def get_date_vertraging(datum, delay):
        sql = "SELECT RitID, Starttijd, TIME_TO_SEC(TIMEDIFF(EchteAankomst, VerwachteAankomst)) as 'Vertraging' FROM tblRitten WHERE date(Starttijd) = %s HAVING Vertraging >= %s;"
        params = [datum, delay]
        return Database.get_rows(sql, params)

    @staticmethod
    def insert_rit_start(start, aankomst, spoor = 1):
        sql = "INSERT INTO tblRitten(Starttijd, VerwachteAankomst, SpoorID) VALUES ('2021-06-14 09:47:00', '2021-06-14 09:52:00', 1);"
        params = [start, aankomst, spoor]
        return Database.get_rows(sql, params)

    @staticmethod
    def insert_rit_start(VertragingID):
        sql = "INSERT INTO tblRitten(EchteAankomst, VertragingTypeID) VALUES ('2021-06-14 09:52:00', 1);"
        params = [VertragingID]
        return Database.get_rows(sql, params)