enum ExpenseTag {
  STUFF,
  SHOPPING,
  PARTY,
  TICKETS,
  HANG_OUT,
  DRINKING,
  PETROL,
  WATER
}

String expenseTagToString(ExpenseTag tag) {
  switch (tag) {
    case ExpenseTag.STUFF:
      return 'Stuff';

    case ExpenseTag.SHOPPING:
      return 'Shopping';

    case ExpenseTag.PARTY:
      return 'Party';

    case ExpenseTag.TICKETS:
      return 'Tickets';

    case ExpenseTag.HANG_OUT:
      return 'Hang out';

    case ExpenseTag.DRINKING:
      return 'Drinking';

    case ExpenseTag.PETROL:
      return 'Petrol';

    case ExpenseTag.WATER:
      return 'Water';
  }

  return '';
}
