-----------------------------------
-- Goblin Mafia
-----------------------------------

xi = xi or {}
xi.mafia = xi.mafia or {}

xi.mafia.GIL_REWARD = 13515

xi.mafia.CONTRACTS =
{
    [1]   = { mobId = zones[xi.zone.VALLEY_OF_SORROWS].mob.ADAMANTOISE, mobName = 'Adamantoise', item = xi.item.HEAVY_CUIRASS, itemName = 'Heavy Cuirass', reward = 1000, bonus = 100 },
    [2]   = { mobId = zones[xi.zone.ATTOHWA_CHASM].mob.ALASTOR_ANTLION, mobName = 'Alastor Antlion', item = xi.item.ROSTRUM_PUMPS, itemName = 'Rostrum Pumps', reward = 1000, bonus = 1000 },
    [3]   = { mobId = zones[xi.zone.UPPER_DELKFUTTS_TOWER].mob.ALKYONEUS, mobName = 'Alkyoneus', item = xi.item.ALKYONEUSS_BRACELETS, itemName = 'Alkyoneus\'s Bracelets', reward = 300, bonus = 500 },
    [4]   = { mobId = zones[xi.zone.WEST_RONFAURE].mob.AMANITA, mobName = 'Amanita', item = xi.item.TENAX_STRAP, itemName = 'Tenax Strap', reward = 150, bonus = 100 },
    [5]   = { mobId = zones[xi.zone.ATTOHWA_CHASM].mob.AMBUSHER_ANTLION, mobName = 'Ambusher Antlion', item = xi.item.ARCHERS_JUPON, itemName = 'Archer\'s Jupon', reward = 500, bonus = 300 },
    [6]   = { mobId = zones[xi.zone.GUSTAV_TUNNEL].mob.AMIKIRI, mobName = 'Amikiri', item = xi.item.KAMEWARI, itemName = 'Kamewari', reward = 500, bonus = 100 },
    [7]   = { mobId = zones[xi.zone.THE_BOYAHDA_TREE].mob.ANCIENT_GOOBBUE, mobName = 'Ancient Goobbue', item = xi.item.DAIHANNYA, itemName = 'Daihannya', reward = 300, bonus = 100 },
    [8]   = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.ANTICAN_CONSUL, mobName = 'Antican Consul', item = xi.item.BERSERKERS_AXE, itemName = 'Berserker\'s Axe', reward = 300, bonus = 100 },
    [9]   = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.ANTICAN_LEGATUS, mobName = 'Antican Legatus', item = xi.item.PALADINS_TESTIMONY, itemName = 'Pld. Testimony', reward = 100, bonus = 300 },
    [10]  = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.ANTICAN_MAGISTER, mobName = 'Antican Magister', item = xi.item.ARCANABANE, itemName = 'Arcanabane', reward = 500, bonus = 100 },
    [11]  = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.ANTICAN_PRAEFECTUS, mobName = 'Antican Praefectus', item = xi.item.SAVE_THE_QUEEN, itemName = 'Save The Queen', reward = 500, bonus = 100 },
    [12]  = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.ANTICAN_TRIBUNUS, mobName = 'Antican Tribunus', item = xi.item.PHAROAHS_BOW, itemName = 'Pharoah\'s Bow', reward = 500, bonus = 100 },
    [13]  = { mobId = zones[xi.zone.THE_BOYAHDA_TREE].mob.AQUARIUS, mobName = 'Aquarius', item = xi.item.FRANSISCA, itemName = 'Fransisca', reward = 500, bonus = 300 },
    [14]  = { mobId = zones[xi.zone.IFRITS_CAULDRON].mob.ASH_DRAGON, mobName = 'Ash Dragon', item = xi.item.MURASAME, itemName = 'Murasame', reward = 1000, bonus = 1000 },
    [15]  = { mobId = zones[xi.zone.YUGHOTT_GROTTO].mob.ASHMAKER_GOTBLUT, mobName = 'Ashmaker Gotblut', item = xi.item.PRIESTS_ROBE, itemName = 'Priest\'s Robe', reward = 500, bonus = 200 },
    [16]  = { mobId = zones[xi.zone.GUSGEN_MINES].mob.ASPHYXIATED_AMSEL, mobName = 'Asphyxiated Amsel', item = xi.item.MALGUST_RING, itemName = 'Malgust Ring', reward = 150, bonus = 100 },
    [17]  = { mobId = zones[xi.zone.VALLEY_OF_SORROWS].mob.ASPIDOCHELONE, mobName = 'Aspidochelone', item = xi.item.ADAMANTOISE_EGG, itemName = 'Adamantoise Egg', reward = 1000, bonus = 1000 },
    [18]  = { mobId = zones[xi.zone.SAUROMUGUE_CHAMPAIGN_S].mob.BALAM_QUITZ, mobName = 'Balam Quitz', item = xi.item.THUNDERERS_MANTLE, itemName = 'Thunderer\'s Mantle', reward = 500, bonus = 100 },
    [19]  = { mobId = zones[xi.zone.BATALLIA_DOWNS_S].mob.BURLIBIX_BRAWNBACK, mobName = 'Burlibix Brawnback', item = xi.item.SORTIE_RING, itemName = 'Sortie Ring', reward = 500, bonus = 100 },
    [20]  = { mobId = zones[xi.zone.GUSTAV_TUNNEL].mob.BAOBHAN_SITH, mobName = 'Baobhan Sith', item = xi.item.CHEVIOT_CLOTH, itemName = 'Cheviot Cloth', reward = 500, bonus = 100 },
    [21]  = { mobId = zones[xi.zone.CASTLE_ZVAHL_KEEP].mob.BARONET_ROMWE, mobName = 'Baronet Romwe', item = xi.item.DEMONS_AXE, itemName = 'Demon\'s Axe', reward = 500, bonus = 100 },
    [22]  = { mobId = zones[xi.zone.NORTH_GUSTABERG].mob.BEDROCK_BARRY, mobName = 'Bedrock Barry', item = xi.item.FLAWED_GARNET, itemName = 'Flawed Garnet', reward = 150, bonus = 100 },
    [23]  = { mobId = zones[xi.zone.BEHEMOTHS_DOMINION].mob.BEHEMOTH, mobName = 'Behemoth', item = xi.item.COMET_TAIL, itemName = 'Comet Tail', reward = 1000, bonus = 300 },
    [24]  = { mobId = zones[xi.zone.TEMPLE_OF_UGGALEPIH].mob.BERYL_FOOTED_MOLBERRY, mobName = 'Beryl Footed Molberry', item = xi.item.HOTOTOGISU, itemName = 'Hototogisu', reward = 500, bonus = 300 },
    [25]  = { mobId = zones[xi.zone.BEADEAUX].mob.BI_GHO_HEADTAKER, mobName = 'Bi\'Gho Headtaker', item = xi.item.PLANTBANE, itemName = 'Plantbane', reward = 500, bonus = 100 },
    [26]  = { mobId = zones[xi.zone.XARCABARD].mob.BIAST, mobName = 'Biast', item = xi.item.PATROCLUSS_HELM, itemName = 'Patroclus\'s Helm', reward = 500, bonus = 1000 },
    [27]  = { mobId = zones[xi.zone.HALVUNG].mob.BIG_BOMB, mobName = 'Big Bomb', item = xi.item.FIRE_BOMBLET, itemName = 'Fire Bomblet', reward = 500, bonus = 1000 },
    [28]  = { mobId = zones[xi.zone.YHOATOR_JUNGLE].mob.BISQUE_HEELED_SUNBERRY, mobName = 'Bisque-heeled Sunberry', item = xi.item.RANCOR_HANDLE, itemName = 'Rancor Handle', reward = 150, bonus = 100 },
    [29]  = { mobId = zones[xi.zone.PASHHOW_MARSHLANDS].mob.BLOODPOOL_VORAX, mobName = 'Bloodpool Vorax', item = xi.item.BLOODBEAD_AMULET, itemName = 'Bloodbead Amulet', reward = 500, bonus = 200 },
    [30]  = { mobId = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE].mob.BLOODSUCKER, mobName = 'Bloodsucker', item = xi.item.BLOODBEAD_RING, itemName = 'Bloodbead Ring', reward = 100, bonus = 500 },
}

return xi.mafia
