abstract class PatientStates{}


class AppInitialState extends PatientStates{}
class BottomNavBarItemMovedToHome extends PatientStates{}
class BottomNavBarItemMovedToAppointments extends PatientStates{}
class BottomNavBarItemMovedToMessages extends PatientStates{}
class BottomNavBarItemMovedToProfile extends PatientStates{}

class SelectDateSuccessfully extends PatientStates{}
class SelectTimeSuccessfully extends PatientStates{}
class SelectingTimeAndDate extends PatientStates{}

class TimeAndDateSelected extends PatientStates{}
class TimeAndDateSelectedError extends PatientStates{}

class GetPatientAppointmentsSuccess extends PatientStates{}
class GetPatientAppointmentsError extends PatientStates{}
