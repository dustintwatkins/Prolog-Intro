%Customer Facts
customer(hugh).
customer(ida).
customer(jeremy).
customer(leroy).
customer(stella).

%Item Facts
item(balloons).
item(candles).
item(chocolates).
item(place_cards).
item(streamers).

%Event Facts
event(anniversary).
event(charity_auction).
event(retirement).
event(senior_prom).
event(wedding).

%Rose facts
rose(cottage_beauty).
rose(golden_sunset).
rose(mountain_bloom).
rose(pink_paradise).
rose(sweet_dreams).


solve :-
  rose(hugh_rose), rose(ida_rose), rose(jeremy_rose), rose(leroy_rose), rose(stella_rose),
  all_different([hugh_rose, ida_rose, jeremy_rose, leroy_rose, stella_rose]),

  item(hugh_item), item(ida_item), item(jeremy_item), item(leroy_item), item(stella_item),
  all_different([hugh_item, ida_item, jeremy_item, leroy_item, stella_item]),

  event(hugh_event), event(ida_event), event(jeremy_event), event(leroy_event), event(stella_event),
  all_different([hugh_event, ida_event, jeremy_event, leroy_event, stella_event]),

  groupings = [ [hugh, hugh_rose, hugh_item, hugh_event],
            [ida, ida_rose, ida_item, ida_event],
            [jeremy, jeremy_rose, jeremy_item, jeremy_event],
            [leroy, leroy_rose, leroy_item, leroy_event],
            [stella, stella_rose, stella_item, stella_event] ],

%Clue One
  %jeremy_event = senior_prom
  %Stella_event != wedding
  %stella_rose = cottage_beauty

  %member(person, rose, item, event)

  member([hugh, _, _, _], groupings),
  member([ida, _, _, _], groupings),
  member([jeremy, _, _, senior_prom], groupings),
  member([leroy, _, _, _], groupings),
  member([stella, cottage_beauty, _, _,], groupings),

  %stella did not purchase for wedding
  \+ member(stella, _, _, wedding),

%Clue Two
  %hugh_rose = pink_paradise
  %hugh_event != charity_auction
  %hugh_event != wedding

  member([hugh, pink_paradise, _, _], groupings),
  \+ member([hugh, _, _, charity_auction], groupings),
  \+ member([hugh, _, _, wedding], groupings),

%Clue Three
  %person_event = anniversary && person_item = streamers
  %person_event = wedding && person_item = balloons

  member([_, _, streamers, anniversary], groupings),
  member([_, _, balloons, wedding], groupings),

%Clue Four
  %person_rose = sweet_dreams && person_item = chocolates
  %jeremy_rose != mountain_bloom

  member([_, sweet_dreams, chocolates, _], groupings),
  \+ member([jeremy, mountain_bloom, _, _], groupings),

%Clue Five
  %leroy_event = retirement
  %person_event = senior_prom && person_item = candles

  member([leroy, _, _, retirement], groupings),
  member([_, _, candles, senior_prom], groupings),

  tell(hugh, hugh_rose, hugh_item, hugh_event),
  tell(ida, ida_rose, ida_item, ida_event),
  tell(jeremy, jeremy_rose, jeremy_item, jeremy_event),
  tell(leroy, leroy_rose, leroy_item, leroy_event),
  tell(stella, stella_rose, stella_item, stella_event).

all_different([H | T]) :- member(H,T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(C, R, I, E) :-
  write(C), write(' bought the '),
  write(R), write(' rose and '),
  write(I), write(' for the '),
  write(E), write(' event.'), nl.
