class UsageForms {
  static const Map<String, dynamic> config = {
    'refrigerator': {
      'id': 'refrigerator',
      'patterns': [
        {'value': 'rare', 'label': 'Rare / Intermittent use (0–8 hrs/day)'},
        {'value': 'normal', 'label': 'Normal household use (8–16 hrs/day)'},
        {'value': 'heavy', 'label': 'Regular continuous use (16–22 hrs/day)'},
        {'value': 'always', 'label': 'Always ON (24x7)'},
      ],
      'defaultPattern': 'normal',
      'fields': [
        {
          'label': 'Star rating',
          'key': 'fridge_star',
          'options': [
            {'value': 'unknown', 'label': 'Don\'t Know'},
            {'value': '3-star', 'label': '3-star'},
            {'value': '4-star', 'label': '4-star'},
            {'value': '5-star', 'label': '5-star'},
          ],
        },
        {
          'label': 'Capacity',
          'key': 'fridge_capacity',
          'options': [
            {'value': 'unknown', 'label': 'Don\'t Know'},
            {'value': '190L', 'label': '190L'},
            {'value': '215L', 'label': '215L'},
            {'value': '240L', 'label': '240L'},
            {'value': '300L+', 'label': '300L+'},
          ],
        },
      ],
    },
    'air_conditioner': {
      'id': 'ac',
      'patterns': [
        {'value': 'short', 'label': 'Daily – Short duration (1–4 hrs/day)'},
        {'value': 'long', 'label': 'Daily – Long duration (4–8 hrs/day)'},
        {'value': 'night', 'label': 'Mostly Night-time (6–8 hrs/night)'},
      ],
      'defaultPattern': 'short',
      'fields': [
        {
          'label': 'Star rating',
          'key': 'ac_star',
          'options': [
            {'value': 'unknown', 'label': 'Don\'t Know'},
            {'value': '3-star', 'label': '3-star'},
            {'value': '5-star', 'label': '5-star'},
          ],
        },
        {
          'label': 'Tonnage',
          'key': 'ac_tonnage',
          'options': [
            {'value': '1.0', 'label': '1.0 ton'},
            {'value': '1.5', 'label': '1.5 ton'},
            {'value': '2.0', 'label': '2.0 ton'},
          ],
        },
      ],
    },
    'mixer': {
      'id': 'mixer',
      'eventBased': {
        'q1': {
          'question': 'How often do you use the mixer?',
          'options': [
            {'value': 'daily', 'label': 'Daily', 'multiplier': 1.0},
            {'value': '2-3', 'label': 'Few times/week', 'multiplier': 0.43},
            {'value': 'weekly', 'label': 'Once/week', 'multiplier': 0.14},
          ],
        },
        'q2': {
          'question': 'Average mixing time',
          'options': [
            {'value': '5', 'label': '5 min', 'hours': 0.083},
            {'value': '10', 'label': '10 min', 'hours': 0.167},
            {'value': '15', 'label': '15 min', 'hours': 0.25},
          ],
        },
      },
    },
    'fans': {
      'id': 'fan',
      'roomBased': {
        'presets': [
          {'label': 'Evening (5h)', 'val': 5},
          {'label': 'Night (8h)', 'val': 8},
          {'label': 'All Day (12h)', 'val': 12},
        ],
        'defaultHours': 8,
      },
      'fields': [
        {
          'label': 'Fan Type',
          'key': 'fan_type',
          'options': [
            {'value': 'unknown', 'label': 'Don\'t Know'},
            {'value': 'standard', 'label': 'Standard (~75W)'},
            {'value': 'bldc', 'label': 'BLDC (~30W)'},
          ],
        },
      ],
    },
    'pump': {
      'id': 'pump',
      'patterns': [
        {'value': 'normal', 'label': 'Normal (20–30 mins/day)'},
        {'value': 'frequent', 'label': 'Frequent (40–60 mins/day)'},
      ],
      'defaultPattern': 'normal',
      'fields': [
        {
          'label': 'Motor Power',
          'key': 'pump_hp',
          'options': [
            {'value': '0.5', 'label': '0.5 HP'},
            {'value': '1.0', 'label': '1.0 HP'},
            {'value': '1.5', 'label': '1.5 HP'},
          ],
        },
      ],
    },
  };
}
