-- todo:
-- see scripts/zones/Balgas_Dais/npcs/Armoury_Crate.lua
-- copy these into a loot table and pass to tpz.battlefield.HandleLootRolls (like in above script)
-- most bcnms can use their ids as the key, though limbus does its own method

-- you'll need to look up these ids in bcnm_loot table to find any bcnms theyre associated with
-- 10
[10] =
{
    {
        {itemid = 13153, droprate = 250}, -- Dark Torque
        {itemid = 13156, droprate = 250}, -- Elemental Torque
        {itemid = 13157, droprate = 250}, -- Healing Torque
        {itemid = 13161, droprate = 250}, -- Wind Torque
    },
    {
        {itemid = 751, droprate = 258}, -- Platinum Beastcoin
        {itemid = 4874, droprate = 48}, -- Scroll Of Absorb-str
        {itemid = 4751, droprate = 143}, -- Scroll Of Erase
        {itemid = 4714, droprate = 119}, -- Scroll Of Phalanx
        {itemid = 4896, droprate = 48}, -- Fire Spirit Pact
        {itemid = 1255, droprate = 48}, -- Chunk Of Fire Ore
        {itemid = 1256, droprate = 48}, -- Chunk Of Ice Ore
        {itemid = 1257, droprate = 48}, -- Chunk Of Wind Ore
        {itemid = 1258, droprate = 48}, -- Chunk Of Earth Ore
        {itemid = 1259, droprate = 48}, -- Chunk Of Lightning Ore
        {itemid = 1260, droprate = 48}, -- Chunk Of Water Ore
        {itemid = 1261, droprate = 48}, -- Chunk Of Light Ore
        {itemid = 1262, droprate = 48}, -- Chunk Of Dark Ore
    },
    {
        {itemid = 751, droprate = 833}, -- Platinum Beastcoin
        {itemid = 1256, droprate = 169}, -- Chunk Of Ice Ore
    },
    {
        {itemid = 13155, droprate = 250}, -- Enfeebling Torque
        {itemid = 13148, droprate = 250}, -- Evasion Torque
        {itemid = 13151, droprate = 250}, -- Guarding Torque
        {itemid = 13158, droprate = 250}, -- Summoning Torque
    },
    {
        {itemid = 654, droprate = 154}, -- Darksteel Ingot
        {itemid = 797, droprate = 154}, -- Painite
        {itemid = 745, droprate = 154}, -- Gold Ingot
        {itemid = 791, droprate = 77}, -- Aquamarine
        {itemid = 4175, droprate = 77}, -- Vile Elixir +1
        {itemid = 653, droprate = 153}, -- Mythril Ingot
        {itemid = 801, droprate = 30}, -- Chrysoberyl
        {itemid = 802, droprate = 30}, -- Moonstone
        {itemid = 803, droprate = 30}, -- Sunstone
        {itemid = 805, droprate = 30}, -- Zircon
        {itemid = 791, droprate = 30}, -- Aquamarine
        {itemid = 702, droprate = 30}, -- Ebony Log
        {itemid = 700, droprate = 30}, -- Mahogany Log
        {itemid = 942, droprate = 30}, -- Philosophers Stone
    },
    {
        {itemid = 654, droprate = 77}, -- Darksteel Ingot
        {itemid = 802, droprate = 134}, -- Moonstone
        {itemid = 652, droprate = 154}, -- Steel Ingot
        {itemid = 801, droprate = 50}, -- Chrysoberyl
        {itemid = 4173, droprate = 154}, -- Hi-reraiser
        {itemid = 784, droprate = 121}, -- Jadeite
        {itemid = 837, droprate = 10}, -- Spool Of Malboro Fiber
        {itemid = 1110, droprate = 10}, -- Vial Of Black Beetle Blood
        {itemid = 769, droprate = 30}, -- Red Rock
        {itemid = 770, droprate = 30}, -- Blue Rock
        {itemid = 771, droprate = 30}, -- Yellow Rock
        {itemid = 772, droprate = 30}, -- Green Rock
        {itemid = 773, droprate = 30}, -- Translucent Rock
        {itemid = 774, droprate = 30}, -- Purple Rock
        {itemid = 775, droprate = 30}, -- Black Rock
        {itemid = 776, droprate = 30}, -- White Rock
        {itemid = 810, droprate = 50}, -- Fluorite
    },
}
-- 100
[100] =
{
    {
        {itemid = 13292, droprate = 80}, -- Guardians Ring
        {itemid = 13287, droprate = 37}, -- Kampfer Ring
        {itemid = 13300, droprate = 59}, -- Conjurers Ring
        {itemid = 13298, droprate = 37}, -- Shinobi Ring
        {itemid = 13293, droprate = 102}, -- Slayers Ring
        {itemid = 13289, droprate = 80}, -- Sorcerers Ring
        {itemid = 13286, droprate = 113}, -- Soldiers Ring
        {itemid = 13294, droprate = 27}, -- Tamers Ring
        {itemid = 13296, droprate = 70}, -- Trackers Ring
        {itemid = 13299, droprate = 37}, -- Drake Ring
        {itemid = 13290, droprate = 37}, -- Fencers Ring
        {itemid = 13295, droprate = 91}, -- Minstrels Ring
        {itemid = 13288, droprate = 91}, -- Medicine Ring
        {itemid = 13291, droprate = 80}, -- Rogues Ring
        {itemid = 13297, droprate = 22}, -- Ronin Ring
        {itemid = 13447, droprate = 37}, -- Platinum Ring
    },
    {
        {itemid = 13548, droprate = 382}, -- Astral Ring
        {itemid = 13447, droprate = 22}, -- Platinum Ring
        {itemid = 4818, droprate = 65}, -- Scroll Of Quake
        {itemid = 859, droprate = 0}, -- Ram Skin
        {itemid = 4172, droprate = 14}, -- Reraiser
        {itemid = 653, droprate = 22}, -- Mythril Ingot
        {itemid = 4902, droprate = 0}, -- Light Spirit Pact
        {itemid = 4814, droprate = 32}, -- Scroll Of Freeze
        {itemid = 4719, droprate = 43}, -- Scroll Of Regen Iii
        {itemid = 4621, droprate = 32}, -- Scroll Of Raise Ii
        {itemid = 703, droprate = 14}, -- Petrified Log
        {itemid = 887, droprate = 14}, -- Coral Fragment
        {itemid = 700, droprate = 14}, -- Mahogany Log
        {itemid = 738, droprate = 43}, -- Chunk Of Platinum Ore
        {itemid = 737, droprate = 108}, -- Chunk Of Gold Ore
        {itemid = 645, droprate = 32}, -- Chunk Of Darksteel Ore
        {itemid = 644, droprate = 65}, -- Chunk Of Mythril Ore
        {itemid = 745, droprate = 0}, -- Gold Ingot
        {itemid = 654, droprate = 14}, -- Darksteel Ingot
        {itemid = 746, droprate = 14}, -- Platinum Ingot
        {itemid = 702, droprate = 14}, -- Ebony Log
        {itemid = 895, droprate = 14}, -- Ram Horn
        {itemid = 902, droprate = 14}, -- Demon Horn
        {itemid = 1116, droprate = 0}, -- Manticore Hide
        {itemid = 1122, droprate = 14}, -- Wyvern Skin
        {itemid = 866, droprate = 14}, -- Handful Of Wyvern Scales
    },
}
-- 104
[104] =
{
    {
        {itemid = 816, droprate = 1000}, -- Spool Of Silk Thread
    },
    {
        {itemid = 816, droprate = 500}, -- Spool Of Silk Thread
    },
    {
        {itemid = 816, droprate = 330}, -- Spool Of Silk Thread
    },
    {
        {itemid = 14738, droprate = 90}, -- Magicians Earring
        {itemid = 14737, droprate = 90}, -- Wyvern Earring
        {itemid = 14736, droprate = 90}, -- Genin Earring
        {itemid = 14735, droprate = 90}, -- Ashigaru Earring
        {itemid = 14734, droprate = 90}, -- Beaters Earring
        {itemid = 14733, droprate = 90}, -- Singers Earring
        {itemid = 14732, droprate = 90}, -- Trimmers Earring
        {itemid = 14731, droprate = 90}, -- Killer Earring
        {itemid = 14730, droprate = 90}, -- Esquires Earring
        {itemid = 14729, droprate = 90}, -- Pilferers Earring
    },
    {
        {itemid = 13439, droprate = 90}, -- Warlocks Earring
        {itemid = 13438, droprate = 90}, -- Wizards Earring
        {itemid = 13437, droprate = 90}, -- Healers Earring
        {itemid = 13436, droprate = 90}, -- Wrestlers Earring
        {itemid = 13435, droprate = 90}, -- Mercenarys Earring
    },
    {
        {itemid = 1134, droprate = 110}, -- Sheet Of Bast Parchment
        {itemid = 4116, droprate = 150}, -- Hi-potion
        {itemid = 4132, droprate = 150}, -- Hi-ether
    },
    {
        {itemid = 694, droprate = 100}, -- Chestnut Log
        {itemid = 690, droprate = 100}, -- Elm Log
        {itemid = 651, droprate = 80}, -- Iron Ingot
        {itemid = 653, droprate = 80}, -- Mythril Ingot
        {itemid = 744, droprate = 80}, -- Silver Ingot
        {itemid = 652, droprate = 80}, -- Steel Ingot
    },
    {
        {itemid = 644, droprate = 100}, -- Chunk Of Mythril Ore
        {itemid = 645, droprate = 100}, -- Chunk Of Darksteel Ore
        {itemid = 736, droprate = 100}, -- Chunk Of Silver Ore
        {itemid = 806, droprate = 80}, -- Tourmaline
        {itemid = 814, droprate = 80}, -- Amber Stone
        {itemid = 795, droprate = 80}, -- Lapis Lazuli
        {itemid = 799, droprate = 80}, -- Onyx
        {itemid = 807, droprate = 80}, -- Sardonyx
    },
    {
        {itemid = 4751, droprate = 200}, -- Scroll Of Erase
        {itemid = 4868, droprate = 150}, -- Scroll Of Dispel
        {itemid = 5070, droprate = 200}, -- Scroll Of Magic Finale
        {itemid = 4947, droprate = 100}, -- Scroll Of Utsusemi Ni
    },
}
-- 105
[105] =
{
    {
        {itemid = 1603, droprate = 100}, -- Mannequin Hands
    },
    {
        {itemid = 915, droprate = 250}, -- Jar Of Toad Oil
        {itemid = 4112, droprate = 300}, -- Potion
        {itemid = 4113, droprate = 180}, -- Potion +1
        {itemid = 4898, droprate = 130}, -- Air Spirit Pact
        {itemid = 825, droprate = 280}, -- Square Of Cotton Cloth
    },
    {
        {itemid = 749, droprate = 250}, -- Mythril Beastcoin
        {itemid = 17786, droprate = 190}, -- Ganko
        {itemid = 827, droprate = 270}, -- Square Of Wool Cloth
        {itemid = 18171, droprate = 145}, -- Platoon Disc
        {itemid = 824, droprate = 295}, -- Square Of Grass Cloth
        {itemid = 826, droprate = 260}, -- Square Of Linen Cloth
    },
    {
        {itemid = 18209, droprate = 100}, -- Platoon Cutter
        {itemid = 0, droprate = 100}, --
    },
    {
        {itemid = 924, droprate = 100}, -- Vial Of Fiend Blood
    },
    {
        {itemid = 924, droprate = 100}, -- Vial Of Fiend Blood
    },
    {
        {itemid = 18170, droprate = 235}, -- Platoon Edge
        {itemid = 17271, droprate = 235}, -- Platoon Gun
        {itemid = 17692, droprate = 235}, -- Platoon Spatha
        {itemid = 17571, droprate = 235}, -- Platoon Pole
        {itemid = 17820, droprate = 255}, -- Gunromaru
        {itemid = 1601, droprate = 260}, -- Mannequin Head
        {itemid = 4853, droprate = 250}, -- Scroll Of Drain
        {itemid = 930, droprate = 190}, -- Vial Of Beastman Blood
    },
}
-- 107
[107] =
{
    {
        {itemid = 3339, droprate = 1000}, -- Jug Of Honey Wine
    },
    {
        {itemid = 1441, droprate = 312}, -- Libation Abjuration
        {itemid = 17694, droprate = 182}, -- Guespiere
        {itemid = 18047, droprate = 65}, -- Havoc Scythe
        {itemid = 17937, droprate = 43}, -- Leopard Axe
        {itemid = 18173, droprate = 181}, -- Nokizaru Shuriken
        {itemid = 17823, droprate = 217}, -- Shinsoku
        {itemid = 17575, droprate = 43}, -- Somnus Signa
    },
    {
        {itemid = 722, droprate = 94}, -- Divine Log
        {itemid = 1446, droprate = 196}, -- Lacquer Tree Log
        {itemid = 703, droprate = 572}, -- Petrified Log
        {itemid = 831, droprate = 43}, -- Square Of Shining Cloth
    },
    {
        {itemid = 1442, droprate = 159}, -- Oblation Abjuration
        {itemid = 17695, droprate = 151}, -- Bayards Sword
        {itemid = 18088, droprate = 167}, -- Dreizack
        {itemid = 17576, droprate = 95}, -- Grim Staff
        {itemid = 17245, droprate = 95}, -- Grosveneurs Bow
        {itemid = 17996, droprate = 56}, -- Stylet
        {itemid = 17789, droprate = 341}, -- Unsho
    },
    {
        {itemid = 4486, droprate = 522}, -- Dragon Heart
        {itemid = 4272, droprate = 346}, -- Slice Of Dragon Meat
        {itemid = 17928, droprate = 82}, -- Juggernaut
        {itemid = 13189, droprate = 59}, -- Speed Belt
    },
    {
        {itemid = 887, droprate = 32}, -- Coral Fragment
        {itemid = 645, droprate = 71}, -- Chunk Of Darksteel Ore
        {itemid = 902, droprate = 79}, -- Demon Horn
        {itemid = 702, droprate = 56}, -- Ebony Log
        {itemid = 737, droprate = 71}, -- Chunk Of Gold Ore
        {itemid = 823, droprate = 32}, -- Spool Of Gold Thread
        {itemid = 4173, droprate = 48}, -- Hi-reraiser
        {itemid = 700, droprate = 127}, -- Mahogany Log
        {itemid = 644, droprate = 111}, -- Chunk Of Mythril Ore
        {itemid = 703, droprate = 183}, -- Petrified Log
        {itemid = 942, droprate = 40}, -- Philosophers Stone
        {itemid = 738, droprate = 56}, -- Chunk Of Platinum Ore
        {itemid = 895, droprate = 24}, -- Ram Horn
        {itemid = 1132, droprate = 119}, -- Square Of Raxa
        {itemid = 4172, droprate = 56}, -- Reraiser
        {itemid = 4175, droprate = 40}, -- Vile Elixir +1
        {itemid = 866, droprate = 24}, -- Handful Of Wyvern Scales
    },
    {
        {itemid = 1526, droprate = 210}, -- Wyrm Beard
        {itemid = 1313, droprate = 775}, -- Lock Of Sirens Hair
    },
    {
        {itemid = 4209, droprate = 94}, -- Mind Potion
        {itemid = 4207, droprate = 130}, -- Intelligence Potion
        {itemid = 4211, droprate = 116}, -- Charisma Potion
        {itemid = 4213, droprate = 51}, -- Icarus Wing
        {itemid = 1132, droprate = 246}, -- Square Of Raxa
        {itemid = 17582, droprate = 246}, -- Prelatic Pole
    },
    {
        {itemid = 4135, droprate = 290}, -- Hi-ether +3
        {itemid = 4119, droprate = 225}, -- Hi-potion +3
        {itemid = 4173, droprate = 210}, -- Hi-reraiser
        {itemid = 4175, droprate = 217}, -- Vile Elixir +1
    },
    {
        {itemid = 887, droprate = 87}, -- Coral Fragment
        {itemid = 645, droprate = 80}, -- Chunk Of Darksteel Ore
        {itemid = 902, droprate = 58}, -- Demon Horn
        {itemid = 702, droprate = 72}, -- Ebony Log
        {itemid = 737, droprate = 87}, -- Chunk Of Gold Ore
        {itemid = 823, droprate = 14}, -- Spool Of Gold Thread
        {itemid = 4173, droprate = 22}, -- Hi-reraiser
        {itemid = 700, droprate = 80}, -- Mahogany Log
        {itemid = 644, droprate = 36}, -- Chunk Of Mythril Ore
        {itemid = 703, droprate = 145}, -- Petrified Log
        {itemid = 844, droprate = 7}, -- Phoenix Feather
        {itemid = 738, droprate = 51}, -- Chunk Of Platinum Ore
        {itemid = 830, droprate = 29}, -- Square Of Rainbow Cloth
        {itemid = 895, droprate = 36}, -- Ram Horn
        {itemid = 1132, droprate = 72}, -- Square Of Raxa
        {itemid = 4172, droprate = 29}, -- Reraiser
        {itemid = 4174, droprate = 29}, -- Vile Elixir
        {itemid = 4175, droprate = 7}, -- Vile Elixir +1
        {itemid = 866, droprate = 22}, -- Handful Of Wyvern Scales
    },
    {
        {itemid = 1110, droprate = 58}, -- Vial Of Black Beetle Blood
        {itemid = 836, droprate = 36}, -- Square Of Damascene Cloth
        {itemid = 658, droprate = 72}, -- Damascus Ingot
        {itemid = 837, droprate = 22}, -- Spool Of Malboro Fiber
        {itemid = 942, droprate = 275}, -- Philosophers Stone
        {itemid = 844, droprate = 196}, -- Phoenix Feather
        {itemid = 1132, droprate = 225}, -- Square Of Raxa
    },
}
-- 11
[11] =
{
    {
        {itemid = 1441, droprate = 169}, -- Libation Abjuration
        {itemid = 17939, droprate = 268}, -- Kriegsbeil
        {itemid = 17823, droprate = 99}, -- Shinsoku
        {itemid = 18173, droprate = 85}, -- Nokizaru Shuriken
        {itemid = 17694, droprate = 70}, -- Guespiere
        {itemid = 17464, droprate = 85}, -- Purgatory Mace
        {itemid = 18351, droprate = 225}, -- Meteor Cesti
    },
    {
        {itemid = 1442, droprate = 169}, -- Oblation Abjuration
        {itemid = 17789, droprate = 14}, -- Unsho
        {itemid = 17838, droprate = 239}, -- Harlequins Horn
        {itemid = 18088, droprate = 85}, -- Dreizack
        {itemid = 18211, droprate = 254}, -- Gawains Axe
        {itemid = 17578, droprate = 183}, -- Zen Pole
        {itemid = 17695, droprate = 70}, -- Bayards Sword
    },
    {
        {itemid = 703, droprate = 563}, -- Petrified Log
        {itemid = 1446, droprate = 296}, -- Lacquer Tree Log
        {itemid = 831, droprate = 14}, -- Square Of Shining Cloth
        {itemid = 722, droprate = 141}, -- Divine Log
    },
    {
        {itemid = 860, droprate = 535}, -- Behemoth Hide
        {itemid = 883, droprate = 366}, -- Behemoth Horn
        {itemid = 17108, droprate = 48}, -- Healing Staff
    },
    {
        {itemid = 902, droprate = 99}, -- Demon Horn
        {itemid = 703, droprate = 70}, -- Petrified Log
        {itemid = 1132, droprate = 70}, -- Square Of Raxa
        {itemid = 830, droprate = 28}, -- Square Of Rainbow Cloth
        {itemid = 4173, droprate = 113}, -- Hi-reraiser
        {itemid = 703, droprate = 211}, -- Petrified Log
        {itemid = 942, droprate = 141}, -- Philosophers Stone
        {itemid = 737, droprate = 56}, -- Chunk Of Gold Ore
        {itemid = 644, droprate = 85}, -- Chunk Of Mythril Ore
        {itemid = 887, droprate = 70}, -- Coral Fragment
        {itemid = 700, droprate = 85}, -- Mahogany Log
        {itemid = 866, droprate = 42}, -- Handful Of Wyvern Scales
        {itemid = 645, droprate = 42}, -- Chunk Of Darksteel Ore
        {itemid = 895, droprate = 70}, -- Ram Horn
        {itemid = 702, droprate = 85}, -- Ebony Log
        {itemid = 4172, droprate = 28}, -- Reraiser
        {itemid = 738, droprate = 42}, -- Chunk Of Platinum Ore
        {itemid = 4174, droprate = 42}, -- Vile Elixir
        {itemid = 4175, droprate = 7}, -- Vile Elixir +1
    },
    {
        {itemid = 1527, droprate = 208}, -- Behemoth Tongue
        {itemid = 883, droprate = 296}, -- Behemoth Horn
        {itemid = 4199, droprate = 155}, -- Strength Potion
        {itemid = 4201, droprate = 70}, -- Dexterity Potion
        {itemid = 4205, droprate = 141}, -- Agility Potion
        {itemid = 4203, droprate = 113}, -- Vitality Potion
    },
    {
        {itemid = 3341, droprate = 1000}, -- Beastly Shank
    },
    {
        {itemid = 4209, droprate = 169}, -- Mind Potion
        {itemid = 4207, droprate = 70}, -- Intelligence Potion
        {itemid = 4211, droprate = 113}, -- Charisma Potion
        {itemid = 4213, droprate = 155}, -- Icarus Wing
        {itemid = 17840, droprate = 254}, -- Angel Lyre
        {itemid = 785, droprate = 99}, -- Emerald
        {itemid = 804, droprate = 42}, -- Spinel
        {itemid = 786, droprate = 56}, -- Ruby
        {itemid = 787, droprate = 28}, -- Diamond
    },
    {
        {itemid = 4135, droprate = 296}, -- Hi-ether +3
        {itemid = 4119, droprate = 225}, -- Hi-potion +3
        {itemid = 4173, droprate = 197}, -- Hi-reraiser
        {itemid = 4175, droprate = 282}, -- Vile Elixir +1
    },
    {
        {itemid = 887, droprate = 141}, -- Coral Fragment
        {itemid = 1132, droprate = 14}, -- Square Of Raxa
        {itemid = 902, droprate = 113}, -- Demon Horn
        {itemid = 737, droprate = 28}, -- Chunk Of Gold Ore
        {itemid = 644, droprate = 85}, -- Chunk Of Mythril Ore
        {itemid = 4174, droprate = 56}, -- Vile Elixir
        {itemid = 895, droprate = 28}, -- Ram Horn
        {itemid = 703, droprate = 296}, -- Petrified Log
        {itemid = 738, droprate = 14}, -- Chunk Of Platinum Ore
        {itemid = 700, droprate = 56}, -- Mahogany Log
        {itemid = 866, droprate = 70}, -- Handful Of Wyvern Scales
        {itemid = 1465, droprate = 42}, -- Slab Of Granite
        {itemid = 645, droprate = 42}, -- Chunk Of Darksteel Ore
        {itemid = 702, droprate = 42}, -- Ebony Log
        {itemid = 4173, droprate = 42}, -- Hi-reraiser
        {itemid = 823, droprate = 113}, -- Spool Of Gold Thread
        {itemid = 830, droprate = 28}, -- Square Of Rainbow Cloth
    },
    {
        {itemid = 1132, droprate = 127}, -- Square Of Raxa
        {itemid = 837, droprate = 56}, -- Spool Of Malboro Fiber
        {itemid = 942, droprate = 225}, -- Philosophers Stone
        {itemid = 844, droprate = 423}, -- Phoenix Feather
        {itemid = 836, droprate = 70}, -- Square Of Damascene Cloth
        {itemid = 658, droprate = 42}, -- Damascus Ingot
        {itemid = 1110, droprate = 85}, -- Vial Of Black Beetle Blood
    },
}
-- 110
[110] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1939, droprate = 350}, -- Square Of Cardinal Cloth
        {itemid = 1941, droprate = 278}, -- Spool Of Light Filament
        {itemid = 1959, droprate = 174}, -- Square Of Astral Leather
        {itemid = 1949, droprate = 200}, -- Square Of Brown Doeskin
    },
    {
        {itemid = 1945, droprate = 47}, -- Black Rivet
        {itemid = 1951, droprate = 49}, -- Square Of Charcoal Cotton
        {itemid = 1955, droprate = 200}, -- Pot Of Ebony Lacquer
        {itemid = 2659, droprate = 62}, -- Square Of Canvas Toile
        {itemid = 2715, droprate = 407}, -- Gold Stud
    },
}
-- 111
[111] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1959, droprate = 47}, -- Square Of Astral Leather
        {itemid = 1949, droprate = 30}, -- Square Of Brown Doeskin
        {itemid = 1943, droprate = 200}, -- White Rivet
        {itemid = 1947, droprate = 460}, -- Fetid Lanolin Cube
        {itemid = 2661, droprate = 400}, -- Square Of Corduroy Cloth
    },
    {
        {itemid = 1951, droprate = 20}, -- Square Of Charcoal Cotton
        {itemid = 1955, droprate = 80}, -- Pot Of Ebony Lacquer
        {itemid = 1945, droprate = 90}, -- Black Rivet
        {itemid = 2659, droprate = 100}, -- Square Of Canvas Toile
        {itemid = 2715, droprate = 120}, -- Gold Stud
    },
}
-- 112
[112] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1955, droprate = 59}, -- Pot Of Ebony Lacquer
        {itemid = 1959, droprate = 139}, -- Square Of Astral Leather
        {itemid = 1949, droprate = 39}, -- Square Of Brown Doeskin
        {itemid = 1681, droprate = 39}, -- Light Steel Ingot
        {itemid = 645, droprate = 39}, -- Chunk Of Darksteel Ore
        {itemid = 1933, droprate = 627}, -- Ancient Brass Ingot
    },
    {
        {itemid = 1945, droprate = 159}, -- Black Rivet
        {itemid = 1951, droprate = 139}, -- Square Of Charcoal Cotton
        {itemid = 2659, droprate = 39}, -- Square Of Canvas Toile
        {itemid = 664, droprate = 20}, -- Darksteel Sheet
        {itemid = 646, droprate = 20}, -- Chunk Of Adaman Ore
        {itemid = 1931, droprate = 200}, -- Argyro Rivet
    },
}
-- 113
[113] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1935, droprate = 220}, -- Spool Of Benedict Yarn
        {itemid = 1937, droprate = 300}, -- Spool Of Diabolic Yarn
        {itemid = 1957, droprate = 260}, -- Blue Rivet
        {itemid = 1953, droprate = 340}, -- Sheet Of Kurogane
    },
    {
        {itemid = 2657, droprate = 220}, -- Square Of Flameshun Cloth
        {itemid = 2717, droprate = 180}, -- Electrum Stud
        {itemid = 1931, droprate = 300}, -- Argyro Rivet
    },
    {
        {itemid = 1909, droprate = 1000}, -- Smalt Chip
    },
    {
        {itemid = 2127, droprate = 59}, -- Metal Chip
        {itemid = 1875, droprate = 100}, -- Ancient Beastcoin
    },
}
-- 114
[114] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1953, droprate = 304}, -- Sheet Of Kurogane
        {itemid = 1943, droprate = 18}, -- White Rivet
        {itemid = 1941, droprate = 200}, -- Spool Of Light Filament
        {itemid = 2715, droprate = 200}, -- Gold Stud
        {itemid = 2661, droprate = 36}, -- Square Of Corduroy Cloth
    },
    {
        {itemid = 1933, droprate = 18}, -- Ancient Brass Ingot
        {itemid = 1939, droprate = 36}, -- Square Of Cardinal Cloth
        {itemid = 1935, droprate = 411}, -- Spool Of Benedict Yarn
        {itemid = 2717, droprate = 482}, -- Electrum Stud
        {itemid = 1947, droprate = 18}, -- Fetid Lanolin Cube
    },
}
-- 115
[115] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1947, droprate = 26}, -- Fetid Lanolin Cube
        {itemid = 1933, droprate = 53}, -- Ancient Brass Ingot
        {itemid = 1943, droprate = 26}, -- White Rivet
        {itemid = 2661, droprate = 26}, -- Square Of Corduroy Cloth
        {itemid = 1937, droprate = 395}, -- Spool Of Diabolic Yarn
    },
    {
        {itemid = 1957, droprate = 289}, -- Blue Rivet
        {itemid = 1941, droprate = 53}, -- Spool Of Light Filament
        {itemid = 1939, droprate = 112}, -- Square Of Cardinal Cloth
        {itemid = 2657, droprate = 477}, -- Square Of Flameshun Cloth
    },
}
-- 116
[116] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1931, droprate = 788}, -- Argyro Rivet
        {itemid = 1939, droprate = 30}, -- Square Of Cardinal Cloth
        {itemid = 1953, droprate = 130}, -- Sheet Of Kurogane
        {itemid = 1957, droprate = 100}, -- Blue Rivet
        {itemid = 1947, droprate = 90}, -- Fetid Lanolin Cube
    },
    {
        {itemid = 1933, droprate = 30}, -- Ancient Brass Ingot
        {itemid = 1941, droprate = 99}, -- Spool Of Light Filament
        {itemid = 2661, droprate = 61}, -- Square Of Corduroy Cloth
        {itemid = 2715, droprate = 30}, -- Gold Stud
        {itemid = 1943, droprate = 160}, -- White Rivet
    },
    {
        {itemid = 1633, droprate = 30}, -- Handful Of Clot Plasma
        {itemid = 821, droprate = 40}, -- Spool Of Rainbow Thread
    },
    {
        {itemid = 1311, droprate = 50}, -- Piece Of Oxblood
        {itemid = 1883, droprate = 40}, -- Ponze Of Shell Powder
        {itemid = 2004, droprate = 20}, -- Ponze Of Carapace Powder
    },
}
-- 117
[117] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1949, droprate = 326}, -- Square Of Brown Doeskin
        {itemid = 1945, droprate = 256}, -- Black Rivet
        {itemid = 1951, droprate = 395}, -- Square Of Charcoal Cotton
    },
    {
        {itemid = 1959, droprate = 279}, -- Square Of Astral Leather
        {itemid = 1955, droprate = 256}, -- Pot Of Ebony Lacquer
        {itemid = 2659, droprate = 326}, -- Square Of Canvas Toile
    },
}
-- 118
[118] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 100}, -- Ancient Beastcoin
        {itemid = 2127, droprate = 59}, -- Metal Chip
    },
    {
        {itemid = 1910, droprate = 1000}, -- Smoky Chip
    },
}
-- 119
[119] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1949, droprate = 464}, -- Square Of Brown Doeskin
        {itemid = 1945, droprate = 250}, -- Black Rivet
        {itemid = 1953, droprate = 110}, -- Sheet Of Kurogane
        {itemid = 1937, droprate = 71}, -- Spool Of Diabolic Yarn
    },
    {
        {itemid = 1931, droprate = 180}, -- Argyro Rivet
        {itemid = 2657, droprate = 210}, -- Square Of Flameshun Cloth
        {itemid = 2717, droprate = 111}, -- Electrum Stud
        {itemid = 1935, droprate = 107}, -- Spool Of Benedict Yarn
    },
}
-- 12
[12] =
{
    {
        {itemid = 846, droprate = 1000}, -- Insect Wing
    },
    {
        {itemid = 1601, droprate = 1000}, -- Mannequin Head
    },
    {
        {itemid = 12486, droprate = 364}, -- Emperor Hairpin
    },
    {
        {itemid = 12400, droprate = 175}, -- Ashigaru Targe
        {itemid = 12399, droprate = 175}, -- Beaters Aspis
        {itemid = 12395, droprate = 175}, -- Varlets Targe
        {itemid = 12390, droprate = 175}, -- Wrestlers Aspis
        {itemid = 809, droprate = 100}, -- Clear Topaz
        {itemid = 795, droprate = 100}, -- Lapis Lazuli
        {itemid = 796, droprate = 100}, -- Light Opal
    },
    {
        {itemid = 13659, droprate = 250}, -- Mercenary Mantle
        {itemid = 13668, droprate = 250}, -- Singers Mantle
        {itemid = 13662, droprate = 250}, -- Wizards Mantle
        {itemid = 13672, droprate = 250}, -- Wyvern Mantle
    },
    {
        {itemid = 4947, droprate = 70}, -- Scroll Of Utsusemi Ni
        {itemid = 5070, droprate = 70}, -- Scroll Of Magic Finale
        {itemid = 17863, droprate = 150}, -- Jug Of Quadav Bug Broth
        {itemid = 799, droprate = 100}, -- Onyx
        {itemid = 795, droprate = 100}, -- Lapis Lazuli
        {itemid = 796, droprate = 100}, -- Light Opal
        {itemid = 4868, droprate = 150}, -- Scroll Of Dispel
        {itemid = 4751, droprate = 100}, -- Scroll Of Erase
        {itemid = 690, droprate = 90}, -- Elm Log
        {itemid = 1602, droprate = 70}, -- Mannequin Body
    },
}
-- 120
[120] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1951, droprate = 154}, -- Square Of Charcoal Cotton
        {itemid = 1935, droprate = 95}, -- Spool Of Benedict Yarn
        {itemid = 1959, droprate = 269}, -- Square Of Astral Leather
    },
    {
        {itemid = 1937, droprate = 106}, -- Spool Of Diabolic Yarn
        {itemid = 1931, droprate = 77}, -- Argyro Rivet
        {itemid = 2659, droprate = 423}, -- Square Of Canvas Toile
        {itemid = 1957, droprate = 110}, -- Blue Rivet
    },
}
-- 121
[121] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1955, droprate = 595}, -- Pot Of Ebony Lacquer
        {itemid = 1957, droprate = 100}, -- Blue Rivet
        {itemid = 1937, droprate = 24}, -- Spool Of Diabolic Yarn
        {itemid = 1953, droprate = 48}, -- Sheet Of Kurogane
    },
    {
        {itemid = 1931, droprate = 120}, -- Argyro Rivet
        {itemid = 1953, droprate = 48}, -- Sheet Of Kurogane
        {itemid = 1935, droprate = 24}, -- Spool Of Benedict Yarn
        {itemid = 2657, droprate = 24}, -- Square Of Flameshun Cloth
        {itemid = 2717, droprate = 71}, -- Electrum Stud
    },
    {
        {itemid = 1311, droprate = 32}, -- Piece Of Oxblood
        {itemid = 1883, droprate = 40}, -- Ponze Of Shell Powder
        {itemid = 1681, droprate = 31}, -- Light Steel Ingot
        {itemid = 1633, droprate = 71}, -- Handful Of Clot Plasma
        {itemid = 645, droprate = 31}, -- Chunk Of Darksteel Ore
        {itemid = 664, droprate = 63}, -- Darksteel Sheet
        {itemid = 646, droprate = 31}, -- Chunk Of Adaman Ore
        {itemid = 821, droprate = 63}, -- Spool Of Rainbow Thread
    },
}
-- 122
[122] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1941, droprate = 468}, -- Spool Of Light Filament
        {itemid = 1947, droprate = 340}, -- Fetid Lanolin Cube
        {itemid = 1933, droprate = 255}, -- Ancient Brass Ingot
        {itemid = 1939, droprate = 191}, -- Square Of Cardinal Cloth
    },
    {
        {itemid = 1943, droprate = 170}, -- White Rivet
        {itemid = 2661, droprate = 340}, -- Square Of Corduroy Cloth
        {itemid = 2715, droprate = 170}, -- Gold Stud
    },
    {
        {itemid = 1987, droprate = 1000}, -- Charcoal Chip
    },
    {
        {itemid = 2127, droprate = 59}, -- Metal Chip
        {itemid = 1875, droprate = 100}, -- Ancient Beastcoin
    },
}
-- 123
[123] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1937, droprate = 25}, -- Spool Of Diabolic Yarn
        {itemid = 2657, droprate = 175}, -- Square Of Flameshun Cloth
        {itemid = 1957, droprate = 100}, -- Blue Rivet
        {itemid = 1943, droprate = 25}, -- White Rivet
        {itemid = 1953, droprate = 250}, -- Sheet Of Kurogane
        {itemid = 2717, droprate = 75}, -- Electrum Stud
        {itemid = 1931, droprate = 225}, -- Argyro Rivet
        {itemid = 1935, droprate = 50}, -- Spool Of Benedict Yarn
    },
}
-- 124
[124] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1943, droprate = 235}, -- White Rivet
        {itemid = 2659, droprate = 59}, -- Square Of Canvas Toile
        {itemid = 1945, droprate = 235}, -- Black Rivet
        {itemid = 1955, droprate = 147}, -- Pot Of Ebony Lacquer
        {itemid = 1951, droprate = 118}, -- Square Of Charcoal Cotton
        {itemid = 1959, droprate = 176}, -- Square Of Astral Leather
        {itemid = 1935, droprate = 110}, -- Spool Of Benedict Yarn
    },
}
-- 125
[125] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1947, droprate = 133}, -- Fetid Lanolin Cube
        {itemid = 1933, droprate = 133}, -- Ancient Brass Ingot
        {itemid = 1943, droprate = 133}, -- White Rivet
        {itemid = 2661, droprate = 133}, -- Square Of Corduroy Cloth
        {itemid = 1939, droprate = 110}, -- Square Of Cardinal Cloth
        {itemid = 1941, droprate = 400}, -- Spool Of Light Filament
    },
    {
        {itemid = 646, droprate = 50}, -- Chunk Of Adaman Ore
        {itemid = 1633, droprate = 50}, -- Handful Of Clot Plasma
        {itemid = 664, droprate = 50}, -- Darksteel Sheet
        {itemid = 645, droprate = 50}, -- Chunk Of Darksteel Ore
        {itemid = 1311, droprate = 50}, -- Piece Of Oxblood
        {itemid = 1681, droprate = 50}, -- Light Steel Ingot
        {itemid = 821, droprate = 50}, -- Spool Of Rainbow Thread
        {itemid = 1883, droprate = 50}, -- Ponze Of Shell Powder
    },
}
-- 126
[126] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1937, droprate = 80}, -- Spool Of Diabolic Yarn
        {itemid = 2657, droprate = 70}, -- Square Of Flameshun Cloth
        {itemid = 1949, droprate = 48}, -- Square Of Brown Doeskin
        {itemid = 1947, droprate = 30}, -- Fetid Lanolin Cube
        {itemid = 2659, droprate = 25}, -- Square Of Canvas Toile
        {itemid = 1957, droprate = 19}, -- Blue Rivet
        {itemid = 1945, droprate = 48}, -- Black Rivet
        {itemid = 1933, droprate = 90}, -- Ancient Brass Ingot
        {itemid = 1955, droprate = 00}, -- Pot Of Ebony Lacquer
        {itemid = 2661, droprate = 48}, -- Square Of Corduroy Cloth
        {itemid = 1939, droprate = 136}, -- Square Of Cardinal Cloth
        {itemid = 1951, droprate = 80}, -- Square Of Charcoal Cotton
        {itemid = 1953, droprate = 110}, -- Sheet Of Kurogane
        {itemid = 1959, droprate = 95}, -- Square Of Astral Leather
        {itemid = 2715, droprate = 123}, -- Gold Stud
        {itemid = 1935, droprate = 48}, -- Spool Of Benedict Yarn
    },
}
-- 127
[127] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1937, droprate = 109}, -- Spool Of Diabolic Yarn
        {itemid = 2657, droprate = 152}, -- Square Of Flameshun Cloth
        {itemid = 1949, droprate = 283}, -- Square Of Brown Doeskin
        {itemid = 1947, droprate = 109}, -- Fetid Lanolin Cube
        {itemid = 2659, droprate = 65}, -- Square Of Canvas Toile
        {itemid = 2715, droprate = 130}, -- Gold Stud
    },
    {
        {itemid = 1957, droprate = 65}, -- Blue Rivet
        {itemid = 1945, droprate = 174}, -- Black Rivet
        {itemid = 1933, droprate = 130}, -- Ancient Brass Ingot
        {itemid = 1955, droprate = 196}, -- Pot Of Ebony Lacquer
        {itemid = 1943, droprate = 174}, -- White Rivet
        {itemid = 2661, droprate = 174}, -- Square Of Corduroy Cloth
        {itemid = 1939, droprate = 109}, -- Square Of Cardinal Cloth
    },
    {
        {itemid = 1951, droprate = 130}, -- Square Of Charcoal Cotton
        {itemid = 1953, droprate = 304}, -- Sheet Of Kurogane
        {itemid = 2717, droprate = 87}, -- Electrum Stud
        {itemid = 1959, droprate = 217}, -- Square Of Astral Leather
        {itemid = 1941, droprate = 174}, -- Spool Of Light Filament
        {itemid = 1931, droprate = 130}, -- Argyro Rivet
        {itemid = 1935, droprate = 109}, -- Spool Of Benedict Yarn
    },
    {
        {itemid = 1988, droprate = 1000}, -- Magenta Chip
    },
    {
        {itemid = 2127, droprate = 59}, -- Metal Chip
        {itemid = 1875, droprate = 100}, -- Ancient Beastcoin
    },
}
-- 128
[128] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1925, droprate = 659}, -- Piece Of Omegas Eye
        {itemid = 1927, droprate = 394}, -- Segment Of Omegas Foreleg
        {itemid = 1928, droprate = 388}, -- Segment Of Omegas Hind Leg
        {itemid = 1929, droprate = 404}, -- Segment Of Omegas Tail
    },
    {
        {itemid = 1928, droprate = 394}, -- Segment Of Omegas Hind Leg
        {itemid = 1929, droprate = 402}, -- Segment Of Omegas Tail
        {itemid = 1925, droprate = 659}, -- Piece Of Omegas Eye
        {itemid = 1927, droprate = 383}, -- Segment Of Omegas Foreleg
    },
    {
        {itemid = 1926, droprate = 265}, -- Piece Of Omegas Heart
        {itemid = 1875, droprate = 100}, -- Ancient Beastcoin
    },
}
-- 129
[129] =
{
    {
        {itemid = 1933, droprate = 9}, -- Ancient Brass Ingot
        {itemid = 1931, droprate = 53}, -- Argyro Rivet
        {itemid = 1959, droprate = 6}, -- Square Of Astral Leather
        {itemid = 1935, droprate = 12}, -- Spool Of Benedict Yarn
        {itemid = 1945, droprate = 29}, -- Black Rivet
        {itemid = 1957, droprate = 12}, -- Blue Rivet
        {itemid = 1949, droprate = 35}, -- Square Of Brown Doeskin
        {itemid = 2659, droprate = 35}, -- Square Of Canvas Toile
        {itemid = 1939, droprate = 12}, -- Square Of Cardinal Cloth
        {itemid = 1951, droprate = 12}, -- Square Of Charcoal Cotton
        {itemid = 2661, droprate = 12}, -- Square Of Corduroy Cloth
        {itemid = 1937, droprate = 18}, -- Spool Of Diabolic Yarn
        {itemid = 1955, droprate = 29}, -- Pot Of Ebony Lacquer
        {itemid = 2717, droprate = 12}, -- Electrum Stud
        {itemid = 1947, droprate = 12}, -- Fetid Lanolin Cube
        {itemid = 2657, droprate = 18}, -- Square Of Flameshun Cloth
        {itemid = 2715, droprate = 5}, -- Gold Stud
        {itemid = 1953, droprate = 35}, -- Sheet Of Kurogane
        {itemid = 1941, droprate = 41}, -- Spool Of Light Filament
        {itemid = 1943, droprate = 18}, -- White Rivet
        {itemid = 1987, droprate = 53}, -- Charcoal Chip
        {itemid = 1988, droprate = 76}, -- Magenta Chip
        {itemid = 1909, droprate = 64}, -- Smalt Chip
        {itemid = 1910, droprate = 41}, -- Smoky Chip
    },
    {
        {itemid = 646, droprate = 50}, -- Chunk Of Adaman Ore
        {itemid = 1633, droprate = 50}, -- Handful Of Clot Plasma
        {itemid = 664, droprate = 50}, -- Darksteel Sheet
        {itemid = 645, droprate = 50}, -- Chunk Of Darksteel Ore
        {itemid = 1311, droprate = 50}, -- Piece Of Oxblood
        {itemid = 1681, droprate = 50}, -- Light Steel Ingot
        {itemid = 821, droprate = 50}, -- Spool Of Rainbow Thread
        {itemid = 1883, droprate = 50}, -- Ponze Of Shell Powder
    },
}
-- 130
[130] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1954, droprate = 159}, -- Plaited Cord
        {itemid = 1940, droprate = 146}, -- Square Of Supple Skin
        {itemid = 1932, droprate = 85}, -- Utopian Gold Thread
        {itemid = 1956, droprate = 171}, -- Sheet Of Cobalt Mythril
        {itemid = 1934, droprate = 110}, -- Square Of Benedict Silk
        {itemid = 2658, droprate = 220}, -- Spool Of Silkworm Thread
        {itemid = 2716, droprate = 98}, -- Square Of Brilliantine
    },
}
-- 131
[131] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1932, droprate = 333}, -- Utopian Gold Thread
        {itemid = 1954, droprate = 200}, -- Plaited Cord
        {itemid = 1950, droprate = 100}, -- Spool Of Chameleon Yarn
        {itemid = 1940, droprate = 90}, -- Square Of Supple Skin
        {itemid = 1942, droprate = 70}, -- Chunk Of Snowy Cermet
        {itemid = 1934, droprate = 90}, -- Square Of Benedict Silk
        {itemid = 1936, droprate = 100}, -- Square Of Diabolic Silk
        {itemid = 1958, droprate = 90}, -- Spool Of Glittering Yarn
        {itemid = 2656, droprate = 67}, -- Spool Of Luminian Thread
        {itemid = 1956, droprate = 167}, -- Sheet Of Cobalt Mythril
    },
}
-- 132
[132] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1956, droprate = 27}, -- Sheet Of Cobalt Mythril
        {itemid = 1932, droprate = 324}, -- Utopian Gold Thread
        {itemid = 1950, droprate = 80}, -- Spool Of Chameleon Yarn
        {itemid = 1934, droprate = 189}, -- Square Of Benedict Silk
        {itemid = 1930, droprate = 50}, -- Square Of Ecarlate Cloth
    },
    {
        {itemid = 1940, droprate = 27}, -- Square Of Supple Skin
        {itemid = 1936, droprate = 81}, -- Square Of Diabolic Silk
        {itemid = 1944, droprate = 80}, -- Dark Orichalcum Ingot
        {itemid = 1958, droprate = 81}, -- Spool Of Glittering Yarn
        {itemid = 2658, droprate = 270}, -- Spool Of Silkworm Thread
        {itemid = 2714, droprate = 108}, -- Square Of Filet Lace
    },
}
-- 133
[133] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1942, droprate = 90}, -- Chunk Of Snowy Cermet
        {itemid = 1934, droprate = 435}, -- Square Of Benedict Silk
        {itemid = 1956, droprate = 80}, -- Sheet Of Cobalt Mythril
        {itemid = 1940, droprate = 174}, -- Square Of Supple Skin
        {itemid = 1958, droprate = 87}, -- Spool Of Glittering Yarn
        {itemid = 1954, droprate = 90}, -- Plaited Cord
        {itemid = 1936, droprate = 87}, -- Square Of Diabolic Silk
        {itemid = 1930, droprate = 43}, -- Square Of Ecarlate Cloth
        {itemid = 2656, droprate = 27}, -- Spool Of Luminian Thread
        {itemid = 2658, droprate = 261}, -- Spool Of Silkworm Thread
    },
}
-- 134
[134] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1954, droprate = 67}, -- Plaited Cord
        {itemid = 1940, droprate = 353}, -- Square Of Supple Skin
        {itemid = 1936, droprate = 87}, -- Square Of Diabolic Silk
        {itemid = 1956, droprate = 110}, -- Sheet Of Cobalt Mythril
        {itemid = 1958, droprate = 87}, -- Spool Of Glittering Yarn
        {itemid = 1942, droprate = 50}, -- Chunk Of Snowy Cermet
        {itemid = 1950, droprate = 60}, -- Spool Of Chameleon Yarn
        {itemid = 1932, droprate = 59}, -- Utopian Gold Thread
        {itemid = 2716, droprate = 100}, -- Square Of Brilliantine
        {itemid = 2714, droprate = 110}, -- Square Of Filet Lace
    },
}
-- 135
[135] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1954, droprate = 263}, -- Plaited Cord
        {itemid = 1932, droprate = 59}, -- Utopian Gold Thread
        {itemid = 1942, droprate = 53}, -- Chunk Of Snowy Cermet
        {itemid = 1934, droprate = 60}, -- Square Of Benedict Silk
        {itemid = 1956, droprate = 526}, -- Sheet Of Cobalt Mythril
    },
    {
        {itemid = 1930, droprate = 60}, -- Square Of Ecarlate Cloth
        {itemid = 1936, droprate = 53}, -- Square Of Diabolic Silk
        {itemid = 1950, droprate = 158}, -- Spool Of Chameleon Yarn
        {itemid = 2716, droprate = 105}, -- Square Of Brilliantine
    },
}
-- 136
[136] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1956, droprate = 240}, -- Sheet Of Cobalt Mythril
        {itemid = 1932, droprate = 120}, -- Utopian Gold Thread
        {itemid = 1940, droprate = 200}, -- Square Of Supple Skin
    },
    {
        {itemid = 1934, droprate = 40}, -- Square Of Benedict Silk
        {itemid = 1954, droprate = 120}, -- Plaited Cord
        {itemid = 2658, droprate = 200}, -- Spool Of Silkworm Thread
        {itemid = 2716, droprate = 80}, -- Square Of Brilliantine
    },
    {
        {itemid = 1875, droprate = 100}, -- Ancient Beastcoin
        {itemid = 2127, droprate = 55}, -- Metal Chip
    },
    {
        {itemid = 1904, droprate = 1000}, -- Ivory Chip
    },
}
-- 137
[137] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1948, droprate = 172}, -- Spool Of Coiled Yarn
        {itemid = 1938, droprate = 138}, -- Spool Of Ruby Silk Thread
        {itemid = 1952, droprate = 138}, -- Spool Of Scarlet Odoshi
        {itemid = 1958, droprate = 207}, -- Spool Of Glittering Yarn
        {itemid = 1930, droprate = 241}, -- Square Of Ecarlate Cloth
        {itemid = 2656, droprate = 172}, -- Spool Of Luminian Thread
    },
}
-- 138
[138] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1948, droprate = 179}, -- Spool Of Coiled Yarn
        {itemid = 1938, droprate = 571}, -- Spool Of Ruby Silk Thread
        {itemid = 1944, droprate = 71}, -- Dark Orichalcum Ingot
        {itemid = 1952, droprate = 179}, -- Spool Of Scarlet Odoshi
    },
    {
        {itemid = 1946, droprate = 120}, -- Square Of Smalt Leather
        {itemid = 1934, droprate = 71}, -- Square Of Benedict Silk
        {itemid = 1930, droprate = 143}, -- Square Of Ecarlate Cloth
        {itemid = 2660, droprate = 143}, -- Pantin Wire
    },
}
-- 139
[139] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1948, droprate = 536}, -- Spool Of Coiled Yarn
        {itemid = 1952, droprate = 107}, -- Spool Of Scarlet Odoshi
        {itemid = 1938, droprate = 60}, -- Spool Of Ruby Silk Thread
        {itemid = 1934, droprate = 110}, -- Square Of Benedict Silk
        {itemid = 1930, droprate = 80}, -- Square Of Ecarlate Cloth
        {itemid = 2660, droprate = 90}, -- Pantin Wire
    },
    {
        {itemid = 1946, droprate = 71}, -- Square Of Smalt Leather
        {itemid = 1944, droprate = 103}, -- Dark Orichalcum Ingot
        {itemid = 1958, droprate = 160}, -- Spool Of Glittering Yarn
        {itemid = 1954, droprate = 36}, -- Plaited Cord
        {itemid = 2656, droprate = 250}, -- Spool Of Luminian Thread
        {itemid = 2716, droprate = 350}, -- Square Of Brilliantine
    },
}
-- 14
[14] =
{
    {
        {itemid = 13254, droprate = 95}, -- Jungle Belt
        {itemid = 13253, droprate = 95}, -- Steppe Belt
        {itemid = 13255, droprate = 95}, -- Desert Belt
        {itemid = 13252, droprate = 95}, -- Forest Belt
        {itemid = 13256, droprate = 95}, -- Ocean Stone
        {itemid = 13259, droprate = 95}, -- Jungle Stone
        {itemid = 13258, droprate = 95}, -- Steppe Stone
        {itemid = 13260, droprate = 95}, -- Desert Stone
        {itemid = 13257, droprate = 95}, -- Forest Stone
    },
    {
        {itemid = 13292, droprate = 64}, -- Guardians Ring
        {itemid = 13287, droprate = 65}, -- Kampfer Ring
        {itemid = 13300, droprate = 65}, -- Conjurers Ring
        {itemid = 13298, droprate = 65}, -- Shinobi Ring
        {itemid = 13293, droprate = 65}, -- Slayers Ring
        {itemid = 13289, droprate = 65}, -- Sorcerers Ring
        {itemid = 13286, droprate = 64}, -- Soldiers Ring
        {itemid = 13294, droprate = 65}, -- Tamers Ring
        {itemid = 13296, droprate = 64}, -- Trackers Ring
        {itemid = 13299, droprate = 65}, -- Drake Ring
        {itemid = 13290, droprate = 65}, -- Fencers Ring
        {itemid = 13295, droprate = 65}, -- Minstrels Ring
        {itemid = 13288, droprate = 64}, -- Medicine Ring
        {itemid = 13291, droprate = 65}, -- Rogues Ring
        {itemid = 13297, droprate = 64}, -- Ronin Ring
        {itemid = 13447, droprate = 30}, -- Platinum Ring
    },
    {
        {itemid = 4902, droprate = 10}, -- Light Spirit Pact
        {itemid = 4814, droprate = 176}, -- Scroll Of Freeze
        {itemid = 4719, droprate = 176}, -- Scroll Of Regen Iii
        {itemid = 4172, droprate = 60}, -- Reraiser
        {itemid = 4174, droprate = 60}, -- Vile Elixir
        {itemid = 4621, droprate = 176}, -- Scroll Of Raise Ii
    },
    {
        {itemid = 895, droprate = 59}, -- Ram Horn
        {itemid = 700, droprate = 59}, -- Mahogany Log
        {itemid = 653, droprate = 200}, -- Mythril Ingot
        {itemid = 1116, droprate = 59}, -- Manticore Hide
        {itemid = 866, droprate = 90}, -- Handful Of Wyvern Scales
        {itemid = 1122, droprate = 90}, -- Wyvern Skin
        {itemid = 703, droprate = 176}, -- Petrified Log
        {itemid = 654, droprate = 59}, -- Darksteel Ingot
        {itemid = 749, droprate = 59}, -- Mythril Beastcoin
        {itemid = 859, droprate = 59}, -- Ram Skin
        {itemid = 746, droprate = 90}, -- Platinum Ingot
    },
}
-- 140
[140] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1952, droprate = 533}, -- Spool Of Scarlet Odoshi
        {itemid = 1946, droprate = 90}, -- Square Of Smalt Leather
        {itemid = 1938, droprate = 133}, -- Spool Of Ruby Silk Thread
        {itemid = 1932, droprate = 90}, -- Utopian Gold Thread
    },
    {
        {itemid = 1958, droprate = 10}, -- Spool Of Glittering Yarn
        {itemid = 1954, droprate = 133}, -- Plaited Cord
        {itemid = 1944, droprate = 133}, -- Dark Orichalcum Ingot
        {itemid = 1930, droprate = 133}, -- Square Of Ecarlate Cloth
        {itemid = 2660, droprate = 33}, -- Pantin Wire
    },
}
-- 141
[141] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1954, droprate = 59}, -- Plaited Cord
        {itemid = 1930, droprate = 294}, -- Square Of Ecarlate Cloth
        {itemid = 1946, droprate = 59}, -- Square Of Smalt Leather
        {itemid = 1934, droprate = 78}, -- Square Of Benedict Silk
        {itemid = 2716, droprate = 59}, -- Square Of Brilliantine
    },
    {
        {itemid = 1958, droprate = 176}, -- Spool Of Glittering Yarn
        {itemid = 1938, droprate = 59}, -- Spool Of Ruby Silk Thread
        {itemid = 1948, droprate = 25}, -- Spool Of Coiled Yarn
        {itemid = 1932, droprate = 118}, -- Utopian Gold Thread
        {itemid = 2656, droprate = 294}, -- Spool Of Luminian Thread
    },
}
-- 142
[142] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1954, droprate = 200}, -- Plaited Cord
        {itemid = 1958, droprate = 400}, -- Spool Of Glittering Yarn
        {itemid = 1948, droprate = 100}, -- Spool Of Coiled Yarn
        {itemid = 1934, droprate = 150}, -- Square Of Benedict Silk
    },
    {
        {itemid = 1932, droprate = 50}, -- Utopian Gold Thread
        {itemid = 1930, droprate = 60}, -- Square Of Ecarlate Cloth
        {itemid = 1938, droprate = 200}, -- Spool Of Ruby Silk Thread
        {itemid = 1944, droprate = 60}, -- Dark Orichalcum Ingot
        {itemid = 1952, droprate = 200}, -- Spool Of Scarlet Odoshi
    },
}
-- 143
[143] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1948, droprate = 36}, -- Spool Of Coiled Yarn
        {itemid = 1952, droprate = 143}, -- Spool Of Scarlet Odoshi
        {itemid = 1930, droprate = 143}, -- Square Of Ecarlate Cloth
        {itemid = 1958, droprate = 214}, -- Spool Of Glittering Yarn
        {itemid = 1938, droprate = 71}, -- Spool Of Ruby Silk Thread
        {itemid = 2656, droprate = 321}, -- Spool Of Luminian Thread
    },
    {
        {itemid = 1875, droprate = 100}, -- Ancient Beastcoin
        {itemid = 2127, droprate = 55}, -- Metal Chip
    },
    {
        {itemid = 1906, droprate = 1000}, -- Emerald Chip
    },
}
-- 144
[144] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1944, droprate = 65}, -- Dark Orichalcum Ingot
        {itemid = 1936, droprate = 97}, -- Square Of Diabolic Silk
        {itemid = 1946, droprate = 40}, -- Square Of Smalt Leather
        {itemid = 1942, droprate = 95}, -- Chunk Of Snowy Cermet
        {itemid = 2660, droprate = 194}, -- Pantin Wire
        {itemid = 2714, droprate = 32}, -- Square Of Filet Lace
        {itemid = 1950, droprate = 161}, -- Spool Of Chameleon Yarn
        {itemid = 2716, droprate = 190}, -- Square Of Brilliantine
        {itemid = 2656, droprate = 210}, -- Spool Of Luminian Thread
    },
}
-- 145
[145] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1936, droprate = 367}, -- Square Of Diabolic Silk
        {itemid = 1952, droprate = 70}, -- Spool Of Scarlet Odoshi
        {itemid = 1950, droprate = 40}, -- Spool Of Chameleon Yarn
        {itemid = 1942, droprate = 333}, -- Chunk Of Snowy Cermet
        {itemid = 1958, droprate = 20}, -- Spool Of Glittering Yarn
    },
    {
        {itemid = 1956, droprate = 106}, -- Sheet Of Cobalt Mythril
        {itemid = 1938, droprate = 33}, -- Spool Of Ruby Silk Thread
        {itemid = 1944, droprate = 76}, -- Dark Orichalcum Ingot
        {itemid = 1948, droprate = 95}, -- Spool Of Coiled Yarn
        {itemid = 2658, droprate = 67}, -- Spool Of Silkworm Thread
        {itemid = 1946, droprate = 133}, -- Square Of Smalt Leather
    },
}
-- 146
[146] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1942, droprate = 625}, -- Chunk Of Snowy Cermet
        {itemid = 1944, droprate = 102}, -- Dark Orichalcum Ingot
        {itemid = 1950, droprate = 42}, -- Spool Of Chameleon Yarn
        {itemid = 1952, droprate = 83}, -- Spool Of Scarlet Odoshi
        {itemid = 1946, droprate = 50}, -- Square Of Smalt Leather
    },
    {
        {itemid = 1940, droprate = 83}, -- Square Of Supple Skin
        {itemid = 1936, droprate = 70}, -- Square Of Diabolic Silk
        {itemid = 1938, droprate = 42}, -- Spool Of Ruby Silk Thread
        {itemid = 1948, droprate = 42}, -- Spool Of Coiled Yarn
        {itemid = 2660, droprate = 292}, -- Pantin Wire
    },
}
-- 147
[147] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1950, droprate = 417}, -- Spool Of Chameleon Yarn
        {itemid = 1956, droprate = 75}, -- Sheet Of Cobalt Mythril
        {itemid = 1944, droprate = 208}, -- Dark Orichalcum Ingot
        {itemid = 1940, droprate = 167}, -- Square Of Supple Skin
    },
    {
        {itemid = 1946, droprate = 62}, -- Square Of Smalt Leather
        {itemid = 1936, droprate = 69}, -- Square Of Diabolic Silk
        {itemid = 2660, droprate = 208}, -- Pantin Wire
        {itemid = 1952, droprate = 42}, -- Spool Of Scarlet Odoshi
        {itemid = 2658, droprate = 83}, -- Spool Of Silkworm Thread
    },
}
-- 148
[148] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1944, droprate = 208}, -- Dark Orichalcum Ingot
        {itemid = 1938, droprate = 42}, -- Spool Of Ruby Silk Thread
        {itemid = 1946, droprate = 36}, -- Square Of Smalt Leather
        {itemid = 1940, droprate = 83}, -- Square Of Supple Skin
        {itemid = 1942, droprate = 20}, -- Chunk Of Snowy Cermet
    },
    {
        {itemid = 1952, droprate = 94}, -- Spool Of Scarlet Odoshi
        {itemid = 1956, droprate = 42}, -- Sheet Of Cobalt Mythril
        {itemid = 1936, droprate = 49}, -- Square Of Diabolic Silk
        {itemid = 1950, droprate = 167}, -- Spool Of Chameleon Yarn
        {itemid = 2714, droprate = 458}, -- Square Of Filet Lace
    },
}
-- 149
[149] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1942, droprate = 68}, -- Chunk Of Snowy Cermet
        {itemid = 1948, droprate = 74}, -- Spool Of Coiled Yarn
        {itemid = 1936, droprate = 259}, -- Square Of Diabolic Silk
        {itemid = 1940, droprate = 74}, -- Square Of Supple Skin
        {itemid = 1956, droprate = 74}, -- Sheet Of Cobalt Mythril
        {itemid = 1950, droprate = 62}, -- Spool Of Chameleon Yarn
    },
    {
        {itemid = 2656, droprate = 150}, -- Spool Of Luminian Thread
        {itemid = 1938, droprate = 76}, -- Spool Of Ruby Silk Thread
        {itemid = 1952, droprate = 53}, -- Spool Of Scarlet Odoshi
        {itemid = 2658, droprate = 111}, -- Spool Of Silkworm Thread
        {itemid = 2714, droprate = 370}, -- Square Of Filet Lace
        {itemid = 1946, droprate = 333}, -- Square Of Smalt Leather
    },
}
-- 15
[15] =
{
    {
        {itemid = 18378, droprate = 222}, -- Subduer
        {itemid = 17699, droprate = 302}, -- Dissector
        {itemid = 17509, droprate = 245}, -- Destroyers
        {itemid = 18005, droprate = 208}, -- Heart Snatcher
    },
    {
        {itemid = 1133, droprate = 0}, -- Vial Of Dragon Blood
        {itemid = 4486, droprate = 176}, -- Dragon Heart
        {itemid = 4272, droprate = 176}, -- Slice Of Dragon Meat
    },
    {
        {itemid = 19026, droprate = 354}, -- Spear Strap
        {itemid = 19024, droprate = 165}, -- Sword Strap
        {itemid = 19025, droprate = 89}, -- Pole Grip
    },
    {
        {itemid = 14764, droprate = 586}, -- Minuet Earring
        {itemid = 655, droprate = 184}, -- Adaman Ingot
        {itemid = 747, droprate = 207}, -- Orichalcum Ingot
    },
    {
        {itemid = 17842, droprate = 238}, -- Sorrowful Harp
        {itemid = 14762, droprate = 250}, -- Attilas Earring
        {itemid = 17700, droprate = 225}, -- Durandal
        {itemid = 18006, droprate = 275}, -- Hoplites Harpe
    },
    {
        {itemid = 737, droprate = 122}, -- Chunk Of Gold Ore
        {itemid = 4172, droprate = 54}, -- Reraiser
        {itemid = 644, droprate = 41}, -- Chunk Of Mythril Ore
        {itemid = 902, droprate = 81}, -- Demon Horn
        {itemid = 702, droprate = 149}, -- Ebony Log
        {itemid = 866, droprate = 54}, -- Handful Of Wyvern Scales
        {itemid = 4175, droprate = 27}, -- Vile Elixir +1
        {itemid = 700, droprate = 41}, -- Mahogany Log
        {itemid = 887, droprate = 95}, -- Coral Fragment
        {itemid = 703, droprate = 108}, -- Petrified Log
        {itemid = 844, droprate = 135}, -- Phoenix Feather
        {itemid = 738, droprate = 54}, -- Chunk Of Platinum Ore
        {itemid = 895, droprate = 14}, -- Ram Horn
        {itemid = 830, droprate = 14}, -- Square Of Rainbow Cloth
        {itemid = 645, droprate = 68}, -- Chunk Of Darksteel Ore
        {itemid = 4173, droprate = 14}, -- Hi-reraiser
        {itemid = 1132, droprate = 135}, -- Square Of Raxa
    },
    {
        {itemid = 836, droprate = 96}, -- Square Of Damascene Cloth
        {itemid = 658, droprate = 27}, -- Damascus Ingot
        {itemid = 942, droprate = 164}, -- Philosophers Stone
        {itemid = 844, droprate = 260}, -- Phoenix Feather
        {itemid = 837, droprate = 96}, -- Spool Of Malboro Fiber
        {itemid = 1132, droprate = 288}, -- Square Of Raxa
        {itemid = 1110, droprate = 41}, -- Vial Of Black Beetle Blood
    },
}
-- 150
[150] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1942, droprate = 38}, -- Chunk Of Snowy Cermet
        {itemid = 1950, droprate = 67}, -- Spool Of Chameleon Yarn
        {itemid = 1944, droprate = 100}, -- Dark Orichalcum Ingot
        {itemid = 1936, droprate = 233}, -- Square Of Diabolic Silk
        {itemid = 1946, droprate = 80}, -- Square Of Smalt Leather
        {itemid = 2660, droprate = 333}, -- Pantin Wire
        {itemid = 2714, droprate = 67}, -- Square Of Filet Lace
    },
    {
        {itemid = 1875, droprate = 100}, -- Ancient Beastcoin
        {itemid = 2127, droprate = 55}, -- Metal Chip
    },
    {
        {itemid = 1905, droprate = 1000}, -- Scarlet Chip
    },
}
-- 151
[151] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1930, droprate = 265}, -- Square Of Ecarlate Cloth
        {itemid = 1938, droprate = 118}, -- Spool Of Ruby Silk Thread
        {itemid = 1948, droprate = 147}, -- Spool Of Coiled Yarn
        {itemid = 1958, droprate = 147}, -- Spool Of Glittering Yarn
        {itemid = 1952, droprate = 118}, -- Spool Of Scarlet Odoshi
        {itemid = 2656, droprate = 235}, -- Spool Of Luminian Thread
    },
    {
        {itemid = 1986, droprate = 1000}, -- Orchid Chip
    },
}
-- 152
[152] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1944, droprate = 250}, -- Dark Orichalcum Ingot
        {itemid = 1936, droprate = 94}, -- Square Of Diabolic Silk
        {itemid = 1950, droprate = 63}, -- Spool Of Chameleon Yarn
        {itemid = 1942, droprate = 125}, -- Chunk Of Snowy Cermet
        {itemid = 1946, droprate = 63}, -- Square Of Smalt Leather
        {itemid = 2660, droprate = 281}, -- Pantin Wire
        {itemid = 2714, droprate = 125}, -- Square Of Filet Lace
    },
    {
        {itemid = 1908, droprate = 1000}, -- Cerulean Chip
    },
}
-- 153
[153] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1934, droprate = 53}, -- Square Of Benedict Silk
        {itemid = 1940, droprate = 132}, -- Square Of Supple Skin
        {itemid = 1954, droprate = 105}, -- Plaited Cord
        {itemid = 1932, droprate = 211}, -- Utopian Gold Thread
        {itemid = 1956, droprate = 211}, -- Sheet Of Cobalt Mythril
        {itemid = 1930, droprate = 100}, -- Square Of Ecarlate Cloth
        {itemid = 2658, droprate = 211}, -- Spool Of Silkworm Thread
        {itemid = 2716, droprate = 105}, -- Square Of Brilliantine
    },
    {
        {itemid = 1907, droprate = 1000}, -- Silver Chip
    },
}
-- 154
[154] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1920, droprate = 659}, -- Piece Of Ultimas Cerebrum
        {itemid = 1924, droprate = 394}, -- Segment Of Ultimas Tail
        {itemid = 1923, droprate = 388}, -- Segment Of Ultimas Leg
        {itemid = 1922, droprate = 404}, -- Segment Of Ultimas Claw
    },
    {
        {itemid = 1924, droprate = 394}, -- Segment Of Ultimas Tail
        {itemid = 1922, droprate = 402}, -- Segment Of Ultimas Claw
        {itemid = 1920, droprate = 659}, -- Piece Of Ultimas Cerebrum
        {itemid = 1923, droprate = 383}, -- Segment Of Ultimas Leg
    },
    {
        {itemid = 1921, droprate = 265}, -- Piece Of Ultimas Heart
        {itemid = 1875, droprate = 100}, -- Ancient Beastcoin
    },
}
-- 155
[155] =
{
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1875, droprate = 1000}, -- Ancient Beastcoin
    },
    {
        {itemid = 1934, droprate = 200}, -- Square Of Benedict Silk
        {itemid = 1930, droprate = 200}, -- Square Of Ecarlate Cloth
        {itemid = 1958, droprate = 200}, -- Spool Of Glittering Yarn
        {itemid = 2658, droprate = 400}, -- Spool Of Silkworm Thread
        {itemid = 1940, droprate = 200}, -- Square Of Supple Skin
    },
}
-- 156
[156] =
{
    {
        {itemid = 13155, droprate = 100}, -- Enfeebling Torque
        {itemid = 13152, droprate = 100}, -- Divine Torque
        {itemid = 13150, droprate = 100}, -- Shield Torque
        {itemid = 13160, droprate = 100}, -- String Torque
    },
    {
        {itemid = 13156, droprate = 250}, -- Elemental Torque
        {itemid = 13148, droprate = 250}, -- Evasion Torque
        {itemid = 13151, droprate = 250}, -- Guarding Torque
        {itemid = 13154, droprate = 250}, -- Enhancing Torque
        {itemid = 13158, droprate = 250}, -- Summoning Torque
    },
    {
        {itemid = 4896, droprate = 48}, -- Fire Spirit Pact
        {itemid = 4874, droprate = 48}, -- Scroll Of Absorb-str
        {itemid = 4751, droprate = 143}, -- Scroll Of Erase
        {itemid = 4714, droprate = 119}, -- Scroll Of Phalanx
        {itemid = 4621, droprate = 150}, -- Scroll Of Raise Ii
    },
    {
        {itemid = 4175, droprate = 77}, -- Vile Elixir +1
        {itemid = 4173, droprate = 154}, -- Hi-reraiser
    },
    {
        {itemid = 1260, droprate = 48}, -- Chunk Of Water Ore
        {itemid = 1257, droprate = 48}, -- Chunk Of Wind Ore
        {itemid = 1256, droprate = 48}, -- Chunk Of Ice Ore
        {itemid = 1259, droprate = 48}, -- Chunk Of Lightning Ore
        {itemid = 1261, droprate = 48}, -- Chunk Of Light Ore
        {itemid = 1255, droprate = 48}, -- Chunk Of Fire Ore
        {itemid = 1262, droprate = 48}, -- Chunk Of Dark Ore
        {itemid = 1258, droprate = 48}, -- Chunk Of Earth Ore
    },
    {
        {itemid = 887, droprate = 150}, -- Coral Fragment
        {itemid = 837, droprate = 10}, -- Spool Of Malboro Fiber
        {itemid = 751, droprate = 850}, -- Platinum Beastcoin
        {itemid = 810, droprate = 50}, -- Fluorite
        {itemid = 797, droprate = 50}, -- Painite
        {itemid = 803, droprate = 50}, -- Sunstone
        {itemid = 784, droprate = 50}, -- Jadeite
        {itemid = 791, droprate = 50}, -- Aquamarine
        {itemid = 802, droprate = 50}, -- Moonstone
        {itemid = 652, droprate = 100}, -- Steel Ingot
        {itemid = 702, droprate = 30}, -- Ebony Log
        {itemid = 771, droprate = 30}, -- Yellow Rock
        {itemid = 769, droprate = 30}, -- Red Rock
        {itemid = 776, droprate = 30}, -- White Rock
        {itemid = 772, droprate = 30}, -- Green Rock
        {itemid = 773, droprate = 30}, -- Translucent Rock
        {itemid = 801, droprate = 30}, -- Chrysoberyl
        {itemid = 775, droprate = 30}, -- Black Rock
        {itemid = 774, droprate = 30}, -- Purple Rock
    },
}
-- 16
[16] =
{
    {
        {itemid = 13056, droprate = 90}, -- Peacock Charm
    },
    {
        {itemid = 18086, droprate = 48}, -- Behourd Lance
        {itemid = 18046, droprate = 61}, -- Mutilator
        {itemid = 18210, droprate = 46}, -- Raifu
        {itemid = 15286, droprate = 302}, -- Tilt Belt
        {itemid = 18350, droprate = 76}, -- Tourney Patas
    },
    {
        {itemid = 17696, droprate = 42}, -- Buzzard Tuck
        {itemid = 17936, droprate = 77}, -- De Saintres Axe
        {itemid = 17693, droprate = 73}, -- Grudge Sword
        {itemid = 15287, droprate = 258}, -- Mantra Belt
        {itemid = 4717, droprate = 68}, -- Scroll Of Refresh
        {itemid = 4947, droprate = 55}, -- Scroll Of Utsusemi Ni
        {itemid = 4858, droprate = 14}, -- Scroll Of Ice Spikes
    },
    {
        {itemid = 4858, droprate = 114}, -- Scroll Of Ice Spikes
        {itemid = 4717, droprate = 174}, -- Scroll Of Refresh
        {itemid = 4947, droprate = 138}, -- Scroll Of Utsusemi Ni
        {itemid = 769, droprate = 16}, -- Red Rock
        {itemid = 770, droprate = 17}, -- Blue Rock
        {itemid = 771, droprate = 17}, -- Yellow Rock
        {itemid = 772, droprate = 18}, -- Green Rock
        {itemid = 773, droprate = 17}, -- Translucent Rock
        {itemid = 774, droprate = 16}, -- Purple Rock
        {itemid = 775, droprate = 18}, -- Black Rock
        {itemid = 776, droprate = 16}, -- White Rock
        {itemid = 749, droprate = 102}, -- Mythril Beastcoin
        {itemid = 748, droprate = 120}, -- Gold Beastcoin
        {itemid = 699, droprate = 22}, -- Oak Log
        {itemid = 811, droprate = 18}, -- Ametrine
        {itemid = 793, droprate = 18}, -- Black Pearl
        {itemid = 790, droprate = 20}, -- Garnet
        {itemid = 808, droprate = 19}, -- Goshenite
        {itemid = 792, droprate = 21}, -- Pearl
        {itemid = 788, droprate = 35}, -- Peridot
        {itemid = 815, droprate = 17}, -- Sphene
        {itemid = 798, droprate = 23}, -- Turquoise
        {itemid = 4172, droprate = 21}, -- Reraiser
        {itemid = 4174, droprate = 16}, -- Vile Elixir
    },
    {
        {itemid = 4896, droprate = 116}, -- Fire Spirit Pact
        {itemid = 4874, droprate = 113}, -- Scroll Of Absorb-str
        {itemid = 4751, droprate = 137}, -- Scroll Of Erase
        {itemid = 4858, droprate = 67}, -- Scroll Of Ice Spikes
        {itemid = 4714, droprate = 99}, -- Scroll Of Phalanx
        {itemid = 811, droprate = 58}, -- Ametrine
        {itemid = 793, droprate = 52}, -- Black Pearl
        {itemid = 790, droprate = 51}, -- Garnet
        {itemid = 808, droprate = 65}, -- Goshenite
        {itemid = 792, droprate = 61}, -- Pearl
        {itemid = 788, droprate = 63}, -- Peridot
        {itemid = 815, droprate = 55}, -- Sphene
        {itemid = 798, droprate = 62}, -- Turquoise
    },
    {
        {itemid = 939, droprate = 1000}, -- Hecteyes Eye
        {itemid = 914, droprate = 1000}, -- Vial Of Mercury
    },
}
-- 17
[17] =
{
    {
        {itemid = 837, droprate = 1000}, -- Spool Of Malboro Fiber
    },
    {
        {itemid = 17827, droprate = 217}, -- Michishiba-no-tsuyu
        {itemid = 17451, droprate = 174}, -- Morgenstern
        {itemid = 17793, droprate = 333}, -- Senjuinrikio
        {itemid = 17589, droprate = 174}, -- Thyrsusstab
    },
    {
        {itemid = 13402, droprate = 101}, -- Cassie Earring
        {itemid = 19027, droprate = 43}, -- Claymore Grip
        {itemid = 920, droprate = 275}, -- Malboro Vine
        {itemid = 1013, droprate = 275}, -- Morbolger Vine
        {itemid = 19025, droprate = 203}, -- Pole Grip
        {itemid = 19026, droprate = 116}, -- Spear Strap
    },
    {
        {itemid = 655, droprate = 159}, -- Adaman Ingot
        {itemid = 747, droprate = 290}, -- Orichalcum Ingot
        {itemid = 13182, droprate = 406}, -- Oscar Scarf
    },
    {
        {itemid = 15325, droprate = 159}, -- Evokers Boots
        {itemid = 14872, droprate = 217}, -- Ostreger Mitts
        {itemid = 15181, droprate = 145}, -- Pineal Hat
        {itemid = 15387, droprate = 159}, -- Trackers Kecks
    },
    {
        {itemid = 887, droprate = 101}, -- Coral Fragment
        {itemid = 645, droprate = 29}, -- Chunk Of Darksteel Ore
        {itemid = 902, droprate = 29}, -- Demon Horn
        {itemid = 702, droprate = 29}, -- Ebony Log
        {itemid = 737, droprate = 101}, -- Chunk Of Gold Ore
        {itemid = 823, droprate = 29}, -- Spool Of Gold Thread
        {itemid = 1465, droprate = 29}, -- Slab Of Granite
        {itemid = 700, droprate = 43}, -- Mahogany Log
        {itemid = 644, droprate = 29}, -- Chunk Of Mythril Ore
        {itemid = 703, droprate = 58}, -- Petrified Log
        {itemid = 738, droprate = 14}, -- Chunk Of Platinum Ore
        {itemid = 830, droprate = 58}, -- Square Of Rainbow Cloth
        {itemid = 895, droprate = 14}, -- Ram Horn
        {itemid = 4174, droprate = 58}, -- Vile Elixir
        {itemid = 4175, droprate = 29}, -- Vile Elixir +1
        {itemid = 866, droprate = 72}, -- Handful Of Wyvern Scales
    },
    {
        {itemid = 1110, droprate = 87}, -- Vial Of Black Beetle Blood
        {itemid = 658, droprate = 14}, -- Damascus Ingot
        {itemid = 836, droprate = 29}, -- Square Of Damascene Cloth
        {itemid = 837, droprate = 43}, -- Spool Of Malboro Fiber
        {itemid = 942, droprate = 174}, -- Philosophers Stone
        {itemid = 844, droprate = 246}, -- Phoenix Feather
        {itemid = 1132, droprate = 159}, -- Square Of Raxa
    },
}
-- 179
[179] =
{
    {
        {itemid = 1842, droprate = 100}, -- Cloud Evoker
    },
    {
        {itemid = 1763, droprate = 30}, -- Pot Of Viridian Urushi
        {itemid = 1769, droprate = 30}, -- Square Of Galateia
        {itemid = 1764, droprate = 30}, -- Square Of Kejusu Satin
    },
    {
        {itemid = 17946, droprate = 100}, -- Maneater
        {itemid = 18358, droprate = 100}, -- Wagh Baghnakhs
        {itemid = 16976, droprate = 100}, -- Onimaru
        {itemid = 4990, droprate = 230}, -- Scroll Of Armys Paeon V
    },
    {
        {itemid = 17946, droprate = 100}, -- Maneater
        {itemid = 18358, droprate = 100}, -- Wagh Baghnakhs
        {itemid = 16976, droprate = 100}, -- Onimaru
        {itemid = 4990, droprate = 230}, -- Scroll Of Armys Paeon V
    },
}
-- 180
[180] =
{
    {
        {itemid = 1767, droprate = 271}, -- Square Of Eltoro Leather
        {itemid = 1762, droprate = 340}, -- Piece Of Cassia Lumber
        {itemid = 1771, droprate = 330}, -- Dragon Bone
        {itemid = 1842, droprate = 44}, -- Cloud Evoker
    },
    {
        {itemid = 15302, droprate = 123}, -- Scouters Rope
        {itemid = 17277, droprate = 163}, -- Hedgehog Bomb
        {itemid = 17707, droprate = 167}, -- Martial Anelace
        {itemid = 18098, droprate = 148}, -- Martial Lance
        {itemid = 4748, droprate = 281}, -- Scroll Of Raise Iii
    },
    {
        {itemid = 15302, droprate = 128}, -- Scouters Rope
        {itemid = 17277, droprate = 163}, -- Hedgehog Bomb
        {itemid = 17707, droprate = 167}, -- Martial Anelace
        {itemid = 18098, droprate = 153}, -- Martial Lance
        {itemid = 4748, droprate = 271}, -- Scroll Of Raise Iii
    },
}
-- 34
[34] =
{
    {
        {itemid = 891, droprate = 1000}, -- Bat Fang
    },
    {
        {itemid = 4900, droprate = 306}, -- Thunder Spirit Pact
        {itemid = 4744, droprate = 319}, -- Scroll Of Invisible
        {itemid = 4745, droprate = 125}, -- Scroll Of Sneak
        {itemid = 4746, droprate = 222}, -- Scroll Of Deodorize
    },
    {
        {itemid = 17786, droprate = 153}, -- Ganko
        {itemid = 18170, droprate = 139}, -- Platoon Edge
        {itemid = 16687, droprate = 83}, -- Platoon Axe
        {itemid = 17571, droprate = 97}, -- Platoon Pole
        {itemid = 17993, droprate = 125}, -- Platoon Dagger
        {itemid = 749, droprate = 444}, -- Mythril Beastcoin
        {itemid = 773, droprate = 56}, -- Translucent Rock
    },
    {
        {itemid = 17820, droprate = 111}, -- Gunromaru
        {itemid = 17993, droprate = 139}, -- Platoon Dagger
        {itemid = 18170, droprate = 139}, -- Platoon Edge
        {itemid = 18085, droprate = 42}, -- Platoon Lance
        {itemid = 16959, droprate = 181}, -- Platoon Sword
        {itemid = 774, droprate = 97}, -- Purple Rock
        {itemid = 769, droprate = 69}, -- Red Rock
        {itemid = 776, droprate = 14}, -- White Rock
        {itemid = 775, droprate = 28}, -- Black Rock
        {itemid = 772, droprate = 28}, -- Green Rock
        {itemid = 771, droprate = 14}, -- Yellow Rock
        {itemid = 770, droprate = 69}, -- Blue Rock
    },
    {
        {itemid = 13548, droprate = 167}, -- Astral Ring
        {itemid = 922, droprate = 444}, -- Bat Wing
        {itemid = 0, droprate = 600}, --
    },
}
-- 35
[35] =
{
    {
        {itemid = 852, droprate = 1000}, -- Lizard Skin
    },
    {
        {itemid = 13014, droprate = 79}, -- Leaping Boots
        {itemid = 0, droprate = 950}, --
    },
    {
        {itemid = 15282, droprate = 53}, -- Katana Obi
        {itemid = 15275, droprate = 79}, -- Rapier Belt
        {itemid = 15278, droprate = 157}, -- Scythe Belt
        {itemid = 694, droprate = 184}, -- Chestnut Log
        {itemid = 690, droprate = 368}, -- Elm Log
        {itemid = 652, droprate = 79}, -- Steel Ingot
    },
    {
        {itemid = 0, droprate = 600}, --
        {itemid = 15282, droprate = 53}, -- Katana Obi
        {itemid = 15275, droprate = 79}, -- Rapier Belt
        {itemid = 15278, droprate = 157}, -- Scythe Belt
        {itemid = 694, droprate = 184}, -- Chestnut Log
        {itemid = 690, droprate = 368}, -- Elm Log
        {itemid = 652, droprate = 79}, -- Steel Ingot
    },
    {
        {itemid = 15285, droprate = 105}, -- Avatar Belt
        {itemid = 15279, droprate = 105}, -- Pick Belt
        {itemid = 651, droprate = 131}, -- Iron Ingot
        {itemid = 643, droprate = 131}, -- Chunk Of Iron Ore
        {itemid = 644, droprate = 79}, -- Chunk Of Mythril Ore
        {itemid = 736, droprate = 79}, -- Chunk Of Silver Ore
        {itemid = 795, droprate = 131}, -- Lapis Lazuli
    },
    {
        {itemid = 17867, droprate = 552}, -- Jug Of Cold Carrion Broth
        {itemid = 4877, droprate = 263}, -- Scroll Of Absorb-agi
        {itemid = 4878, droprate = 210}, -- Scroll Of Absorb-int
        {itemid = 4876, droprate = 289}, -- Scroll Of Absorb-vit
        {itemid = 4868, droprate = 105}, -- Scroll Of Dispel
        {itemid = 4751, droprate = 79}, -- Scroll Of Erase
        {itemid = 5070, droprate = 421}, -- Scroll Of Magic Finale
        {itemid = 4947, droprate = 79}, -- Scroll Of Utsusemi Ni
    },
    {
        {itemid = 15271, droprate = 552}, -- Axe Belt
        {itemid = 15272, droprate = 131}, -- Cestus Belt
        {itemid = 809, droprate = 0}, -- Clear Topaz
        {itemid = 15276, droprate = 79}, -- Dagger Belt
        {itemid = 645, droprate = 105}, -- Chunk Of Darksteel Ore
        {itemid = 15281, droprate = 26}, -- Gun Belt
        {itemid = 4132, droprate = 184}, -- Hi-ether
        {itemid = 796, droprate = 79}, -- Light Opal
        {itemid = 15273, droprate = 157}, -- Mace Belt
        {itemid = 653, droprate = 210}, -- Mythril Ingot
        {itemid = 799, droprate = 26}, -- Onyx
        {itemid = 15283, droprate = 263}, -- Sarashi
        {itemid = 15277, droprate = 105}, -- Shield Belt
        {itemid = 15280, droprate = 105}, -- Song Belt
        {itemid = 15274, droprate = 131}, -- Staff Belt
        {itemid = 744, droprate = 79}, -- Silver Ingot
        {itemid = 806, droprate = 131}, -- Tourmaline
        {itemid = 0, droprate = 600}, --
    },
    {
        {itemid = 15271, droprate = 552}, -- Axe Belt
        {itemid = 15272, droprate = 131}, -- Cestus Belt
        {itemid = 809, droprate = 0}, -- Clear Topaz
        {itemid = 15276, droprate = 79}, -- Dagger Belt
        {itemid = 645, droprate = 105}, -- Chunk Of Darksteel Ore
        {itemid = 15281, droprate = 26}, -- Gun Belt
        {itemid = 4132, droprate = 184}, -- Hi-ether
        {itemid = 796, droprate = 79}, -- Light Opal
        {itemid = 15273, droprate = 157}, -- Mace Belt
        {itemid = 653, droprate = 210}, -- Mythril Ingot
        {itemid = 799, droprate = 26}, -- Onyx
        {itemid = 15283, droprate = 263}, -- Sarashi
        {itemid = 15277, droprate = 105}, -- Shield Belt
        {itemid = 15280, droprate = 105}, -- Song Belt
        {itemid = 15274, droprate = 131}, -- Staff Belt
        {itemid = 744, droprate = 79}, -- Silver Ingot
        {itemid = 806, droprate = 131}, -- Tourmaline
        {itemid = 0, droprate = 600}, --
    },
}
-- 73
[73] =
{
    {
        {itemid = 4570, droprate = 1000}, -- Bird Egg
    },
    {
        {itemid = 14735, droprate = 125}, -- Ashigaru Earring
        {itemid = 14732, droprate = 125}, -- Trimmers Earring
        {itemid = 14734, droprate = 125}, -- Beaters Earring
        {itemid = 13437, droprate = 125}, -- Healers Earring
        {itemid = 13435, droprate = 125}, -- Mercenarys Earring
        {itemid = 14733, droprate = 125}, -- Singers Earring
        {itemid = 13438, droprate = 125}, -- Wizards Earring
        {itemid = 13436, droprate = 125}, -- Wrestlers Earring
    },
    {
        {itemid = 15285, droprate = 142}, -- Avatar Belt
        {itemid = 15276, droprate = 142}, -- Dagger Belt
        {itemid = 15284, droprate = 142}, -- Lance Belt
        {itemid = 15275, droprate = 142}, -- Rapier Belt
        {itemid = 15283, droprate = 142}, -- Sarashi
        {itemid = 15278, droprate = 142}, -- Scythe Belt
        {itemid = 15277, droprate = 142}, -- Shield Belt
    },
    {
        {itemid = 4868, droprate = 105}, -- Scroll Of Dispel
        {itemid = 4751, droprate = 79}, -- Scroll Of Erase
        {itemid = 5070, droprate = 421}, -- Scroll Of Magic Finale
        {itemid = 4947, droprate = 79}, -- Scroll Of Utsusemi Ni
    },
    {
        {itemid = 847, droprate = 230}, -- Bird Feather
        {itemid = 694, droprate = 30}, -- Chestnut Log
        {itemid = 690, droprate = 25}, -- Elm Log
        {itemid = 4132, droprate = 60}, -- Hi-ether
        {itemid = 4222, droprate = 35}, -- Horn Quiver
        {itemid = 651, droprate = 58}, -- Iron Ingot
        {itemid = 795, droprate = 30}, -- Lapis Lazuli
        {itemid = 796, droprate = 50}, -- Light Opal
        {itemid = 653, droprate = 84}, -- Mythril Ingot
        {itemid = 644, droprate = 99}, -- Chunk Of Mythril Ore
        {itemid = 799, droprate = 60}, -- Onyx
        {itemid = 736, droprate = 80}, -- Chunk Of Silver Ore
        {itemid = 744, droprate = 75}, -- Silver Ingot
    },
}
-- 76
[76] =
{
    {
        {itemid = 18047, droprate = 188}, -- Havoc Scythe
        {itemid = 17939, droprate = 40}, -- Kriegsbeil
        {itemid = 17937, droprate = 170}, -- Leopard Axe
        {itemid = 1441, droprate = 295}, -- Libation Abjuration
        {itemid = 18351, droprate = 40}, -- Meteor Cesti
        {itemid = 17464, droprate = 71}, -- Purgatory Mace
        {itemid = 17575, droprate = 196}, -- Somnus Signa
    },
    {
        {itemid = 18211, droprate = 45}, -- Gawains Axe
        {itemid = 17576, droprate = 242}, -- Grim Staff
        {itemid = 17245, droprate = 230}, -- Grosveneurs Bow
        {itemid = 17838, droprate = 143}, -- Harlequins Horn
        {itemid = 1442, droprate = 161}, -- Oblation Abjuration
        {itemid = 17996, droprate = 143}, -- Stylet
        {itemid = 17578, droprate = 36}, -- Zen Pole
    },
    {
        {itemid = 3343, droprate = 1}, -- Clump Of Blue Pondweed
    },
    {
        {itemid = 683, droprate = 446}, -- Adaman Chain
        {itemid = 908, droprate = 420}, -- Adamantoise Shell
        {itemid = 1312, droprate = 98}, -- Piece Of Angel Skin
        {itemid = 14080, droprate = 36}, -- Strider Boots
    },
    {
        {itemid = 887, droprate = 116}, -- Coral Fragment
        {itemid = 645, droprate = 89}, -- Chunk Of Darksteel Ore
        {itemid = 902, droprate = 71}, -- Demon Horn
        {itemid = 702, droprate = 152}, -- Ebony Log
        {itemid = 737, droprate = 107}, -- Chunk Of Gold Ore
        {itemid = 823, droprate = 89}, -- Spool Of Gold Thread
        {itemid = 1465, droprate = 45}, -- Slab Of Granite
        {itemid = 4173, droprate = 71}, -- Hi-reraiser
        {itemid = 700, droprate = 107}, -- Mahogany Log
        {itemid = 703, droprate = 223}, -- Petrified Log
        {itemid = 738, droprate = 116}, -- Chunk Of Platinum Ore
        {itemid = 830, droprate = 54}, -- Square Of Rainbow Cloth
        {itemid = 895, droprate = 54}, -- Ram Horn
        {itemid = 1132, droprate = 71}, -- Square Of Raxa
        {itemid = 4172, droprate = 45}, -- Reraiser
        {itemid = 866, droprate = 54}, -- Handful Of Wyvern Scales
        {itemid = 4174, droprate = 63}, -- Vile Elixir
        {itemid = 4175, droprate = 45}, -- Vile Elixir +1
    },
    {
        {itemid = 683, droprate = 268}, -- Adaman Chain
        {itemid = 1525, droprate = 143}, -- Adamantoise Egg
        {itemid = 4205, droprate = 80}, -- Agility Potion
        {itemid = 4201, droprate = 143}, -- Dexterity Potion
        {itemid = 4199, droprate = 214}, -- Strength Potion
        {itemid = 4203, droprate = 196}, -- Vitality Potion
    },
    {
        {itemid = 646, droprate = 107}, -- Chunk Of Adaman Ore
        {itemid = 4211, droprate = 89}, -- Charisma Potion
        {itemid = 645, droprate = 179}, -- Chunk Of Darksteel Ore
        {itemid = 4213, droprate = 134}, -- Icarus Wing
        {itemid = 4207, droprate = 152}, -- Intelligence Potion
        {itemid = 4209, droprate = 80}, -- Mind Potion
        {itemid = 739, droprate = 80}, -- Chunk Of Orichalcum Ore
        {itemid = 738, droprate = 107}, -- Chunk Of Platinum Ore
        {itemid = 17698, droprate = 152}, -- Princely Sword
    },
    {
        {itemid = 4135, droprate = 295}, -- Hi-ether +3
        {itemid = 4119, droprate = 250}, -- Hi-potion +3
        {itemid = 4173, droprate = 196}, -- Hi-reraiser
        {itemid = 4175, droprate = 214}, -- Vile Elixir +1
    },
    {
        {itemid = 887, droprate = 139}, -- Coral Fragment
        {itemid = 645, droprate = 59}, -- Chunk Of Darksteel Ore
        {itemid = 902, droprate = 50}, -- Demon Horn
        {itemid = 702, droprate = 109}, -- Ebony Log
        {itemid = 737, droprate = 69}, -- Chunk Of Gold Ore
        {itemid = 1465, droprate = 99}, -- Slab Of Granite
        {itemid = 4173, droprate = 79}, -- Hi-reraiser
        {itemid = 700, droprate = 129}, -- Mahogany Log
        {itemid = 644, droprate = 119}, -- Chunk Of Mythril Ore
        {itemid = 844, droprate = 69}, -- Phoenix Feather
        {itemid = 703, droprate = 168}, -- Petrified Log
        {itemid = 738, droprate = 129}, -- Chunk Of Platinum Ore
        {itemid = 895, droprate = 109}, -- Ram Horn
        {itemid = 1132, droprate = 79}, -- Square Of Raxa
        {itemid = 4174, droprate = 69}, -- Vile Elixir
        {itemid = 866, droprate = 79}, -- Handful Of Wyvern Scales
        {itemid = 4172, droprate = 50}, -- Reraiser
        {itemid = 823, droprate = 89}, -- Spool Of Gold Thread
    },
    {
        {itemid = 1110, droprate = 109}, -- Vial Of Black Beetle Blood
        {itemid = 836, droprate = 89}, -- Square Of Damascene Cloth
        {itemid = 658, droprate = 78}, -- Damascus Ingot
        {itemid = 837, droprate = 99}, -- Spool Of Malboro Fiber
        {itemid = 942, droprate = 188}, -- Philosophers Stone
        {itemid = 844, droprate = 238}, -- Phoenix Feather
        {itemid = 1132, droprate = 109}, -- Square Of Raxa
    },
    {
        {itemid = 722, droprate = 79}, -- Divine Log
        {itemid = 1446, droprate = 257}, -- Lacquer Tree Log
        {itemid = 703, droprate = 337}, -- Petrified Log
        {itemid = 831, droprate = 149}, -- Square Of Shining Cloth
    },
}
-- 79
[79] =
{
    {
        {itemid = 793, droprate = 1000}, -- Black Pearl
    },
    {
        {itemid = 792, droprate = 1000}, -- Pearl
    },
    {
        {itemid = 1311, droprate = 1000}, -- Piece Of Oxblood
    },
    {
        {itemid = 14666, droprate = 447}, -- Teleport Ring Altep
        {itemid = 14662, droprate = 487}, -- Teleport Ring Dem
    },
    {
        {itemid = 13175, droprate = 494}, -- Ajari Bead Necklace
        {itemid = 13176, droprate = 449}, -- Philomath Stole
    },
    {
        {itemid = 791, droprate = 51}, -- Aquamarine
        {itemid = 801, droprate = 32}, -- Chrysoberyl
        {itemid = 654, droprate = 39}, -- Darksteel Ingot
        {itemid = 702, droprate = 21}, -- Ebony Log
        {itemid = 4173, droprate = 32}, -- Hi-reraiser
        {itemid = 745, droprate = 55}, -- Gold Ingot
        {itemid = 784, droprate = 62}, -- Jadeite
        {itemid = 653, droprate = 81}, -- Mythril Ingot
        {itemid = 802, droprate = 56}, -- Moonstone
        {itemid = 797, droprate = 195}, -- Painite
        {itemid = 652, droprate = 58}, -- Steel Ingot
        {itemid = 803, droprate = 38}, -- Sunstone
        {itemid = 773, droprate = 11}, -- Translucent Rock
        {itemid = 4175, droprate = 21}, -- Vile Elixir +1
        {itemid = 771, droprate = 15}, -- Yellow Rock
        {itemid = 805, droprate = 26}, -- Zircon
        {itemid = 769, droprate = 21}, -- Red Rock
        {itemid = 700, droprate = 17}, -- Mahogany Log
        {itemid = 770, droprate = 9}, -- Blue Rock
        {itemid = 810, droprate = 62}, -- Fluorite
        {itemid = 774, droprate = 11}, -- Purple Rock
        {itemid = 775, droprate = 11}, -- Black Rock
        {itemid = 772, droprate = 11}, -- Green Rock
        {itemid = 776, droprate = 9}, -- White Rock
    },
    {
        {itemid = 15185, droprate = 55}, -- Walkure Mask
        {itemid = 17440, droprate = 13}, -- Kraken Club
    },
}
-- 81
[81] =
{
    {
        {itemid = 1473, droprate = 813}, -- High-quality Scorpion Shell
        {itemid = 13552, droprate = 55}, -- Serket Ring
        {itemid = 901, droprate = 123}, -- Venomous Claw
    },
    {
        {itemid = 17207, droprate = 216}, -- Expunger
        {itemid = 18005, droprate = 295}, -- Heart Snatcher
        {itemid = 18217, droprate = 239}, -- Rampager
        {itemid = 17793, droprate = 231}, -- Senjuinrikio
    },
    {
        {itemid = 17624, droprate = 504}, -- Anubiss Knife
        {itemid = 655, droprate = 4}, -- Adaman Ingot
        {itemid = 19027, droprate = 86}, -- Claymore Grip
        {itemid = 747, droprate = 22}, -- Orichalcum Ingot
        {itemid = 19025, droprate = 146}, -- Pole Grip
        {itemid = 19024, droprate = 22}, -- Sword Strap
    },
    {
        {itemid = 15295, droprate = 287}, -- Hierarch Belt
        {itemid = 12407, droprate = 216}, -- Palmerins Shield
        {itemid = 14871, droprate = 198}, -- Trainers Gloves
        {itemid = 15294, droprate = 287}, -- Warwolf Belt
    },
    {
        {itemid = 887, droprate = 52}, -- Coral Fragment
        {itemid = 645, droprate = 56}, -- Chunk Of Darksteel Ore
        {itemid = 902, droprate = 41}, -- Demon Horn
        {itemid = 702, droprate = 63}, -- Ebony Log
        {itemid = 737, droprate = 52}, -- Chunk Of Gold Ore
        {itemid = 823, droprate = 26}, -- Spool Of Gold Thread
        {itemid = 1465, droprate = 11}, -- Slab Of Granite
        {itemid = 4173, droprate = 37}, -- Hi-reraiser
        {itemid = 700, droprate = 101}, -- Mahogany Log
        {itemid = 653, droprate = 0}, -- Mythril Ingot
        {itemid = 644, droprate = 52}, -- Chunk Of Mythril Ore
        {itemid = 703, droprate = 116}, -- Petrified Log
        {itemid = 844, droprate = 15}, -- Phoenix Feather
        {itemid = 942, droprate = 56}, -- Philosophers Stone
        {itemid = 738, droprate = 45}, -- Chunk Of Platinum Ore
        {itemid = 830, droprate = 22}, -- Square Of Rainbow Cloth
        {itemid = 895, droprate = 67}, -- Ram Horn
        {itemid = 1132, droprate = 119}, -- Square Of Raxa
        {itemid = 4172, droprate = 45}, -- Reraiser
        {itemid = 4174, droprate = 19}, -- Vile Elixir
        {itemid = 4175, droprate = 41}, -- Vile Elixir +1
        {itemid = 866, droprate = 34}, -- Handful Of Wyvern Scales
    },
    {
        {itemid = 1110, droprate = 78}, -- Vial Of Black Beetle Blood
        {itemid = 836, droprate = 56}, -- Square Of Damascene Cloth
        {itemid = 658, droprate = 93}, -- Damascus Ingot
        {itemid = 837, droprate = 56}, -- Spool Of Malboro Fiber
        {itemid = 942, droprate = 157}, -- Philosophers Stone
        {itemid = 844, droprate = 276}, -- Phoenix Feather
        {itemid = 1132, droprate = 209}, -- Square Of Raxa
    },
}
-- 82
[82] =
{
    {
        {itemid = 843, droprate = 1000}, -- Giant Bird Plume
    },
    {
        {itemid = 17827, droprate = 217}, -- Michishiba-no-tsuyu
        {itemid = 17699, droprate = 174}, -- Dissector
        {itemid = 17275, droprate = 333}, -- Coffinmaker
        {itemid = 18053, droprate = 174}, -- Gravedigger
    },
    {
        {itemid = 19027, droprate = 144}, -- Claymore Grip
        {itemid = 658, droprate = 275}, -- Damascus Ingot
        {itemid = 843, droprate = 275}, -- Giant Bird Plume
        {itemid = 19025, droprate = 203}, -- Pole Grip
        {itemid = 19026, droprate = 116}, -- Spear Strap
    },
    {
        {itemid = 655, droprate = 159}, -- Adaman Ingot
        {itemid = 747, droprate = 290}, -- Orichalcum Ingot
        {itemid = 14765, droprate = 406}, -- Titanis Earring
    },
    {
        {itemid = 15325, droprate = 159}, -- Evokers Boots
        {itemid = 14872, droprate = 217}, -- Ostreger Mitts
        {itemid = 15181, droprate = 145}, -- Pineal Hat
        {itemid = 15387, droprate = 159}, -- Trackers Kecks
    },
    {
        {itemid = 887, droprate = 101}, -- Coral Fragment
        {itemid = 645, droprate = 29}, -- Chunk Of Darksteel Ore
        {itemid = 902, droprate = 29}, -- Demon Horn
        {itemid = 702, droprate = 29}, -- Ebony Log
        {itemid = 737, droprate = 101}, -- Chunk Of Gold Ore
        {itemid = 823, droprate = 29}, -- Spool Of Gold Thread
        {itemid = 1465, droprate = 29}, -- Slab Of Granite
        {itemid = 700, droprate = 43}, -- Mahogany Log
        {itemid = 644, droprate = 29}, -- Chunk Of Mythril Ore
        {itemid = 703, droprate = 58}, -- Petrified Log
        {itemid = 738, droprate = 14}, -- Chunk Of Platinum Ore
        {itemid = 830, droprate = 58}, -- Square Of Rainbow Cloth
        {itemid = 895, droprate = 14}, -- Ram Horn
        {itemid = 4174, droprate = 58}, -- Vile Elixir
        {itemid = 4175, droprate = 29}, -- Vile Elixir +1
        {itemid = 837, droprate = 72}, -- Spool Of Malboro Fiber
    },
    {
        {itemid = 1110, droprate = 87}, -- Vial Of Black Beetle Blood
        {itemid = 658, droprate = 14}, -- Damascus Ingot
        {itemid = 836, droprate = 29}, -- Square Of Damascene Cloth
        {itemid = 942, droprate = 174}, -- Philosophers Stone
        {itemid = 844, droprate = 246}, -- Phoenix Feather
        {itemid = 1132, droprate = 159}, -- Square Of Raxa
    },
}