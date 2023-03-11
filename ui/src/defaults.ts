export const defaults = {
  game: {
    map: 'forest',
    dm: window.ship,
    turn: null, // whose turn it is within the entities list, by id
  },
  entities: [],
  character: {
    name: 'Mr Brightside',
    xp: 0,
    attributes: {
      str: 0, // how hard do you hit (also influences hp)
      end: 0, // how much stamina
      agi: 0, // how likely you are to hit and avoid being hit
      spt: 0, // how much mana
      mem: 0, // how many spells you can have
      int: 0, // how hard of spells you can learn
    },
    current: {
      dmg: 0, // how much damage you have take from your max hp
    },
  },
};
