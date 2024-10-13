import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health/presentation/bloc/dashboard_view/dashboard_view_bloc.dart';
import 'package:mental_health/presentation/views/dashboard_view/widgets/bottom_navigation_icon.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final String currentUserId;
  final bool specialistSelected;
  final bool chatsSelected;
  final bool consultationsSelected;
  final bool articlesSelected;
  final bool profileSelected;

  const CustomBottomNavigationBar(
      {Key? key,
      required this.specialistSelected,
      required this.chatsSelected,
      required this.consultationsSelected,
      required this.articlesSelected,
      required this.profileSelected, required this.currentUserId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          Column(
            children: [
              BottomNavigationIcon(
                  icon: Icons.accessibility,
                  onSelected: specialistSelected,
                  onClicked: () {
                    BlocProvider.of<DashboardViewBloc>(context).add(SpecialistsClickEvent());
                  }),
              SizedBox(height: 5,),
              Text('Specialists',
              style: TextStyle(
                  fontSize: 12,
                fontWeight: FontWeight.bold
              ),
              ),
            ],
          ),

          Column(
            children: [
              BottomNavigationIcon(
                  icon: Icons.mark_unread_chat_alt_sharp,
                  onSelected: chatsSelected,
                  onClicked: () {
                    BlocProvider.of<DashboardViewBloc>(context).add(ChatsClickEvent());
                  }),
              Text('Chats',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),

          Column(
            children: [
              BottomNavigationIcon(
                  icon: Icons.today_outlined,
                  onSelected: consultationsSelected,
                  onClicked: () {
                    BlocProvider.of<DashboardViewBloc>(context).add(ConsultationsClickEvent(
                      currentUserId: currentUserId,
                    ));
                  }),
              Text('Consultations',
                style: TextStyle(
                  fontSize: 12,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),

          Column(
            children: [
              BottomNavigationIcon(
                  icon: Icons.article,
                  onSelected: articlesSelected,
                  onClicked: () {
                    BlocProvider.of<DashboardViewBloc>(context).add(ArticlesClickEvent());
                  }),
              Text('Articles',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),

          Column(
            children: [
              BottomNavigationIcon(
                  icon: Icons.person,
                  onSelected: profileSelected,
                  onClicked: () {
                    BlocProvider.of<DashboardViewBloc>(context).add(ProfileClickEvent(currentUserId: currentUserId));
                  }),
              Text('Profile',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
