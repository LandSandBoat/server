-----------------------------------
-- Starting Gear Module (Test Server)
-- Automatically gives new characters a full set of gear for testing purposes.
-- Wardrobe layout:
--   W1: Main weapons (first half)
--   W2: Main weapons (second half) + Sub + Ammo
--   W3: Range + Earrings + Neck + Waist + Rings
--   W4: Head + Back
--   W5: Body + Rings
--   W6: Hands + Rings
--   W7: Legs + Rings
--   W8: Feet
--   Inventory: Consumables (food, quivers, pouches, etc.)
--
-- Requires the tester_gear.cpp module to be loaded, which registers
-- the entity:addItemToContainer(itemId, locationId [, qty [, silent]]) method.
-----------------------------------
require('modules/module_utils')
require('scripts/globals/player')
-----------------------------------
-- luacheck: globals addItemToContainer
local m = Module:new('starting_gear')

-- Helper: add equipment to a specific container (e.g. a wardrobe)
local function addGear(player, container, items)
    for _, entry in ipairs(items) do
        local itemId, qty
        if type(entry) == 'table' then
            itemId = entry.id
            qty = entry.qty or 1
        else
            itemId = entry
            qty = 1
        end

        for i = 1, qty do
            addItemToContainer(player, itemId, container, 1, true)
        end
    end
end

-- Helper: add consumables to inventory (stacked)
local function addConsumables(player, items)
    for _, entry in ipairs(items) do
        local itemId, qty
        if type(entry) == 'table' then
            itemId = entry.id
            qty = entry.qty or 1
        else
            itemId = entry
            qty = 1
        end

        player:addItem({ id = itemId, quantity = qty, silent = true })
    end
end

-- ============================================================================
-- W1: Main Weapons (first half)
-- ============================================================================
local wardrobe1Items =
{
    16405, -- Cat Baghnakhs
    16433, -- Legionnaire's Knuckles
    16407, -- Brass Baghnakhs
    16409, -- Lynx Baghnakhs
    16703, -- Impact Knuckles
    16399, -- Katars
    16412, -- Mythril Claws
    16694, -- Tactician Magician's Hooks
    18748, -- Hades Sainti
    17509, -- Destroyers
    18358, -- Wagh Baghnakhs
    16465, -- Bronze Knife
    16449, -- Brass Dagger
    16466, -- Knife
    { id = 16755, qty = 2 }, -- Archer's Knife (x2)
    16747, -- Mercenary Captain's Kukri
    16764, -- Marauder's Knife
    { id = 17611, qty = 2 }, -- Bone Knife +1 (x2)
    16476, -- Darksteel Kukri
    17613, -- Beetle Knife +1
    18001, -- Harpe
    18018, -- Sirocco Kukri
    16480, -- Thief's Knife
    18015, -- Blau Dolch
    16535, -- Bronze Sword
    16530, -- Xiphos
    16544, -- Royal Archer's Sword
    16552, -- Scimitar
    16819, -- Mithran Scimitar
    { id = 16806, qty = 2 }, -- Centurion's Sword (x2)
    16581, -- Holy Sword
    { id = 16807, qty = 2 }, -- Combat Caster's Scimitar (x2)
    16529, -- Musketeer's Sword
    { id = 16557, qty = 2 }, -- Musketeer Commander's Falchion (x2)
    16577, -- Bastard Sword
    17665, -- Ifrit's Blade
    16578, -- Espadon
    17652, -- Joyeuse
    16542, -- Wing Sword
    17707, -- Martial Anelace
    17741, -- Perdu Hanger
    16935, -- Barbarian's Sword
    18375, -- Falx
    16942, -- Balmung
    18378, -- Subduer
    16640, -- Bronze Axe
    16667, -- Light Axe
    16655, -- Rusty Pick
    17947, -- Garde Pick
    16650, -- War Pick
    { id = 16669, qty = 2 }, -- Combat Caster's Axe (x2)
    16676, -- Viking Axe
    17925, -- Fransisca
    17928, -- Juggernaut
    17938, -- Woodville's Axe
    17946, -- Maneater
    16704, -- Butterfly Axe
    16705, -- Great Axe
    16714, -- Neckchopper
    16712, -- Centurion's Axe
    16721, -- Huge Moth Axe
    16710, -- Gigant Axe
    16724, -- Heavy Darksteel Axe
    18206, -- Rune Chopper
    18221, -- Martial Bhuj
    18491, -- Perdu Voulge
    16768, -- Bronze Zaghnal
    16780, -- Legionnaire's Scythe
    16776, -- Mercenary Captain's Scythe
    16798, -- Raven Scythe
    16786, -- Barbarian's Scythe
    16788, -- Vassago's Scythe
    16789, -- Darksteel Scythe
    18058, -- Orichalcum Scythe
}

-- ============================================================================
-- W2: Main Weapons (second half) + Sub + Ammo
-- ============================================================================
local wardrobe2Items =
{
    16832, -- Harpoon
    16833, -- Bronze Spear
    16834, -- Brass Spear
    16852, -- Royal Spearman's Spear
    16844, -- Royal Squire's Halberd
    16845, -- Lance
    16887, -- Peregrine
    16857, -- Wind Spear
    16888, -- Battle Fork
    18093, -- Couse
    18118, -- Dark Mezraq
    18109, -- Leviathan's Couse
    18110, -- Mezraq
    16896, -- Kunai
    { id = 16900, qty = 2 }, -- Wakizashi (x2)
    { id = 17780, qty = 2 }, -- Kyofu (x2)
    16907, -- Busuto
    17792, -- Nikkariaoe
    17782, -- Reppu
    17771, -- Anju
    { id = 16908, qty = 2 }, -- Yoto (x2)
    { id = 16903, qty = 2 }, -- Kabutowari (x2)
    { id = 16904, qty = 2 }, -- Fudo (x2)
    17793, -- Senjuinrikio
    17809, -- Mumeito
    16966, -- Tachi
    17811, -- Katayama Ichimonji
    17820, -- Gunromaru
    16988, -- Kotetsu
    16973, -- Homura
    17812, -- Magoroku
    17813, -- Soboro Sukehiro
    16990, -- Daihannya
    17829, -- Hagun
    17804, -- Ushikirimaru
    17042, -- Bronze Hammer
    18394, -- Pilgrim's Wand
    17043, -- Brass Hammer
    17138, -- Willow Wand +1
    17140, -- Yew Wand +1
    17080, -- Holy Maul
    17143, -- Rose Wand +1
    18396, -- Sea Robber Cudgel
    18395, -- Sea Wolf Cudgel
    18847, -- Seveneyes
    17546, -- Vulcan's Staff
    17558, -- Apollo's Staff
    17548, -- Aquilo's Staff
    17554, -- Jupiter's Staff
    17556, -- Neptune's Staff
    17560, -- Pluto's Staff
    17552, -- Terra's Staff
    17567, -- Kirin's Pole
    12299, -- Aspis
    12306, -- Kite Shield
    16168, -- Sentinel Shield
    12351, -- Astral Shield
    12356, -- Viking Shield
    12387, -- Koenig Shield
    12296, -- Genbu's Shield
    19010, -- Brass Grip +1
    19014, -- Mythril Grip +1
    19025, -- Pole Grip
    19023, -- Staff Strap
    19018, -- Bugard Leather Strap +1
    18136, -- Morion Tathlum
    18139, -- Bomb Core
    17277, -- Hedgehog Bomb
    18254, -- Tiphia Sting
}

-- ============================================================================
-- W3: Range + Earrings + Neck + Waist + Rings
-- ============================================================================
local wardrobe3Items =
{
    17152, -- Shortbow
    17160, -- Longbow
    17167, -- Royal Archer's Longbow
    17178, -- Power Bow +1
    17180, -- Great Bow +1
    17181, -- Battle Bow +1
    17173, -- War Bow +1
    17187, -- Eurytos' Bow
    17212, -- Selene's Bow
    17223, -- Legionnaire's Crossbow
    17211, -- Almogavar Bow
    17229, -- Zamburak +1
    17226, -- Arbalest +1
    17244, -- Othinus' Bow
    17246, -- Ziska's Crossbow
    18715, -- Mars's Hexagun
    18702, -- Trump Gun
    17253, -- Musketeer Gun
    17264, -- Hellfire +1
    17210, -- Martial Gun
    17290, -- Coarse Boomerang
    18141, -- Ungur Boomerang
    17345, -- Flute
    17374, -- Harp +1
    17369, -- Cornette +1
    17368, -- Piccolo +1
    17366, -- Mary's Horn
    17370, -- Gemshorn +1
    17349, -- Faerie Piccolo
    17375, -- Traversiere +1
    17376, -- Rose Harp +1
    17371, -- Horn +1
    17378, -- Angel's Flute +1
    17377, -- Crumhorn +1
    17833, -- Ebony Harp +1
    17840, -- Angel Lyre
    { id = 13326, qty = 2 }, -- Beetle Earring +1 (x2)
    14724, -- Moldavite Earring
    { id = 13369, qty = 2 }, -- Spike Earring (x2)
    14813, -- Brutal Earring
    14812, -- Loquacious Earring
    14743, -- Bushinomimi
    14739, -- Suppanomimi
    15965, -- Ethereal Earring
    13093, -- Justice Badge
    13117, -- Ranger's Necklace
    13061, -- Spike Necklace
    13056, -- Peacock Charm
    16263, -- Beak Necklace
    13156, -- Elemental Torque
    13155, -- Enfeebling Torque
    13161, -- Wind Torque
    13153, -- Dark Torque
    13145, -- Uggalepih Pendant
    27510, -- Fotia Gorget
    15523, -- Chivalrous Chain
    13211, -- Friar's Rope
    13240, -- Warrior's Belt +1
    13201, -- Purple Belt
    13184, -- White Belt
    13202, -- Brown Belt
    13186, -- Black Belt
    15908, -- Qiqirn Sash +1
    13231, -- Life Belt
    15457, -- Swift Belt
    13189, -- Speed Belt
    13220, -- Royal Knight's Belt
    15292, -- Penitent's Rope
    15295, -- Hierarch Belt
    28419, -- Hachirin-no-Obi
    { id = 13548, qty = 2 }, -- Astral Ring (x2)
    { id = 13284, qty = 2 }, -- Eremite's Ring (x2)
    { id = 13282, qty = 2 }, -- Saintly Ring (x2)
    { id = 13522, qty = 2 }, -- Courage Ring (x2)
}

-- ============================================================================
-- W4: Head + Back
-- ============================================================================
local wardrobe4Items =
{
    12432, -- Faceguard
    12456, -- Hachimaki
    12454, -- Bone Mask
    12484, -- Mercenary's Hachimaki
    13901, -- Windurstian Hachimaki
    15165, -- Shade Tiara
    15161, -- Noct Beret
    12438, -- Centurion's Visor
    12470, -- Mercenary Captain's Headgear
    12431, -- Royal Squire's Helm
    15242, -- Crow Beret
    12422, -- Iron Musketeer's Armet
    12430, -- Royal Knight's Bascinet
    16063, -- Jaridah Khud
    13881, -- Arhat's Jinpachi
    13929, -- Errant Hat
    12434, -- Genbu's Kabuto
    15241, -- Nashira Turban
    15240, -- Homam Zucchetto
    12445, -- Dusk Mask
    13927, -- Hecatomb Cap
    13876, -- Zenith Crown
    13934, -- Shura Zunari Kabuto
    13908, -- Crimson Mask
    12421, -- Koenig Schaller
    16064, -- Yigit Turban
    16084, -- Ares's Mask
    16088, -- Skadi's Visor
    16092, -- Usukane Somen
    16096, -- Marduk's Tiara
    16100, -- Morrigan's Coronal
    16106, -- Askar Zucchetto
    16107, -- Denali Bonnet
    16108, -- Goliard Chapeau
    12486, -- Emperor Hairpin
    15184, -- Voyager Sallet
    15270, -- Walahra Turban
    12511, -- Fighter's Mask
    12512, -- Temple Crown
    13855, -- Healer's Cap
    13856, -- Wizard's Petasos
    12513, -- Warlock's Chapeau
    12514, -- Rogue's Bonnet
    12515, -- Gallant Coronet
    12516, -- Chaos Burgeonet
    12517, -- Beast Helm
    13857, -- Choral Roundlet
    12518, -- Hunter's Beret
    13868, -- Myochin Kabuto
    13869, -- Ninja Hatsuburi
    12519, -- Drachen Armet
    12520, -- Evoker's Horn
    15265, -- Magus Keffiyeh
    15266, -- Corsair's Tricorne
    15267, -- Puppetry Taj
    15072, -- Warrior's Mask
    15073, -- Melee Crown
    15074, -- Cleric's Cap
    15075, -- Sorcerer's Petasos
    15076, -- Duelist's Chapeau
    15077, -- Assassin's Bonnet
    15078, -- Valor Coronet
    15079, -- Abyss Burgeonet
    15080, -- Monster Helm
    15081, -- Bard's Roundlet
    15082, -- Scout's Beret
    15083, -- Saotome Kabuto
    15084, -- Koga Hatsuburi
    15085, -- Wyrm Armet
    15086, -- Summoner's Horn
    11465, -- Mirage Keffiyeh
    11468, -- Commodore Tricorne
    11471, -- Pantin Taj
    13613, -- Traveler's Mantle
    13610, -- Black Cape +1
    13618, -- White Cape +1
    13627, -- Prism Cape
    13646, -- Amemet Mantle +1
    13652, -- Umbra Cape
    13656, -- Errant Cape
}

-- ============================================================================
-- W5: Body + Rings
-- ============================================================================
local wardrobe5Items =
{
    12560, -- Scale Mail
    12584, -- Kenpogi
    12608, -- Tunic
    12582, -- Bone Harness
    12609, -- Black Tunic
    12653, -- Mercenary's Gi
    14350, -- Windurstian Gi
    14426, -- Shade Harness
    14422, -- Noct Doublet
    12566, -- Centurion's Scale Mail
    12598, -- Mercenary Captain's Doublet
    12559, -- Royal Squire's Chainmail
    12614, -- Combat Caster's Cloak
    14498, -- Crow Jupon
    12550, -- Iron Musketeer's Cuirass
    12558, -- Royal Knight's Chainmail
    14526, -- Jaridah Peti
    13795, -- Arhat's Gi
    14380, -- Errant Houppelande
    12562, -- Kirin's Osode
    14489, -- Nashira Manteel
    14488, -- Homam Corazza
    12573, -- Dusk Jerkin
    14378, -- Hecatomb Harness
    13787, -- Dalmatica
    14387, -- Shura Togi
    14367, -- Crimson Scale Mail
    12549, -- Koenig Cuirass
    12579, -- Scorpion Harness
    12555, -- Haubergeon
    13748, -- Vermillion Cloak
    14527, -- Yigit Gomlek
    14546, -- Ares's Cuirass
    14550, -- Skadi's Cuirie
    14554, -- Usukane Haramaki
    14558, -- Marduk's Jubbah
    14562, -- Morrigan's Robe
    14568, -- Askar Korazin
    14569, -- Denali Jacket
    14570, -- Goliard Saio
    12638, -- Fighter's Lorica
    12639, -- Temple Cyclas
    12640, -- Healer's Bliaut
    12641, -- Wizard's Coat
    12642, -- Warlock's Tabard
    12643, -- Rogue's Vest
    12644, -- Gallant Surcoat
    12645, -- Chaos Cuirass
    12646, -- Beast Jackcoat
    12647, -- Choral Justaucorps
    12648, -- Hunter's Jerkin
    13781, -- Myochin Domaru
    13782, -- Ninja Chainmail
    12649, -- Drachen Mail
    12650, -- Evoker's Doublet
    14521, -- Magus Jubbah
    14522, -- Corsair's Frac
    14523, -- Puppetry Tobe
    15087, -- Warrior's Lorica
    15088, -- Melee Cyclas
    15089, -- Cleric's Bliaut
    15090, -- Sorcerer's Coat
    15091, -- Duelist's Tabard
    15092, -- Assassin's Vest
    15093, -- Valor Surcoat
    15094, -- Abyss Cuirass
    15095, -- Monster Jackcoat
    15096, -- Bard's Justaucorps
    15097, -- Scout's Jerkin
    15098, -- Saotome Domaru
    15099, -- Koga Chainmail
    15100, -- Wyrm Mail
    15101, -- Summoner's Doublet
    11292, -- Mirage Jubbah
    11295, -- Commodore Frac
    11298, -- Pantin Tobe
    { id = 13501, qty = 2 }, -- Beetle Ring +1 (x2)
    { id = 13504, qty = 2 }, -- Merman's Ring (x2)
}

-- ============================================================================
-- W6: Hands + Rings
-- ============================================================================
local wardrobe6Items =
{
    12688, -- Scale Finger Gauntlets
    12712, -- Tekko
    12736, -- Mitts
    12710, -- Bone Mittens
    12737, -- White Mitts
    12719, -- Mercenary's Tekko
    14043, -- Windurstian Tekko
    14858, -- Shade Mittens
    14854, -- Noct Gloves
    12694, -- Centurion's Finger Gauntlets
    12726, -- Mercenary Captain's Gloves
    12687, -- Royal Squire's Mufflers
    12743, -- Combat Caster's Mitts
    14907, -- Crow Bracers
    12678, -- Iron Musketeer's Gauntlets
    12686, -- Royal Knight's Mufflers
    14934, -- Jaridah Bazubands
    14023, -- Arhat's Tekko
    14078, -- Errant Cuffs
    12690, -- Seiryu's Kote
    14906, -- Nashira Gages
    14905, -- Homam Manopolas
    12701, -- Dusk Gloves
    14076, -- Hecatomb Mittens
    14006, -- Zenith Mitts
    14821, -- Shura Kote
    14058, -- Crimson Finger Gauntlets
    12677, -- Koenig Handschuhs
    13952, -- Ochiudo's Kote
    14935, -- Yigit Gages
    14961, -- Ares's Gauntlets
    14965, -- Skadi's Bazubands
    14969, -- Usukane Gote
    14973, -- Marduk's Dastanas
    14977, -- Morrigan's Cuffs
    14983, -- Askar Manopolas
    14984, -- Denali Wristbands
    14985, -- Goliard Cuffs
    13961, -- Fighter's Mufflers
    13962, -- Temple Gloves
    13963, -- Healer's Mitts
    13964, -- Wizard's Gloves
    13965, -- Warlock's Gloves
    13966, -- Rogue's Armlets
    13967, -- Gallant Gauntlets
    13968, -- Chaos Gauntlets
    13969, -- Beast Gloves
    13970, -- Choral Cuffs
    13971, -- Hunter's Bracers
    13972, -- Myochin Kote
    13973, -- Ninja Tekko
    13974, -- Drachen Finger Gauntlets
    13975, -- Evoker's Bracers
    14928, -- Magus Bazubands
    14929, -- Corsair's Gants
    14930, -- Puppetry Dastanas
    15102, -- Warrior's Mufflers
    15103, -- Melee Gloves
    15104, -- Cleric's Mitts
    15105, -- Sorcerer's Gloves
    15106, -- Duelist's Gloves
    15107, -- Assassin's Armlets
    15108, -- Valor Gauntlets
    15109, -- Abyss Gauntlets
    15110, -- Monster Gloves
    15111, -- Bard's Cuffs
    15112, -- Scout's Bracers
    15113, -- Saotome Kote
    15114, -- Koga Tekko
    15115, -- Wyrm Finger Gauntlets
    15116, -- Summoner's Bracers
    15025, -- Mirage Bazubands
    15028, -- Commodore Gants
    15031, -- Pantin Dastanas
    { id = 13280, qty = 2 }, -- Sniper's Ring (x2)
    15543, -- Rajas Ring
    15545, -- Tamas Ring
    13303, -- Jelly Ring
    13311, -- Heaven's Ring
}

-- ============================================================================
-- W7: Legs + Rings
-- ============================================================================
local wardrobe7Items =
{
    12816, -- Scale Cuisses
    12840, -- Sitabaki
    12864, -- Slacks
    12834, -- Bone Subligar
    12865, -- Black Slacks
    12855, -- Mercenary's Sitabaki
    14269, -- Windurstian Sitabaki
    14327, -- Shade Tights
    14323, -- Noct Brais
    12822, -- Centurion's Cuisses
    12854, -- Mercenary Captain's Hose
    12815, -- Royal Squire's Breeches
    12870, -- Combat Caster's Slacks
    15578, -- Crow Hose
    12806, -- Iron Musketeer's Cuisses
    12814, -- Royal Knight's Breeches
    15605, -- Jaridah Salvars
    14253, -- Arhat's Hakama
    14301, -- Errant Slops
    12818, -- Byakko's Haidate
    15577, -- Nashira Seraweels
    15576, -- Homam Cosciales
    12879, -- Dusk Trousers
    14308, -- Hecatomb Subligar
    14247, -- Zenith Slacks
    14303, -- Shura Haidate
    14280, -- Crimson Cuisses
    12805, -- Koenig Diechlings
    15606, -- Yigit Seraweels
    15625, -- Ares's Flanchard
    15629, -- Skadi's Chausses
    15633, -- Usukane Hizayoroi
    15637, -- Marduk's Shalwar
    15641, -- Morrigan's Slops
    15647, -- Askar Dirs
    15648, -- Denali Kecks
    15649, -- Goliard Trews
    14214, -- Fighter's Cuisses
    14215, -- Temple Hose
    14216, -- Healer's Pantaloons
    14217, -- Wizard's Tonban
    14218, -- Warlock's Tights
    14219, -- Rogue's Culottes
    14220, -- Gallant Breeches
    14221, -- Chaos Flanchard
    14222, -- Beast Trousers
    14223, -- Choral Cannions
    14224, -- Hunter's Braccae
    14225, -- Myochin Haidate
    14226, -- Ninja Hakama
    14227, -- Drachen Brais
    14228, -- Evoker's Spats
    15600, -- Magus Shalwar
    15601, -- Corsair's Culottes
    15602, -- Puppetry Churidars
    15117, -- Warrior's Cuisses
    15118, -- Melee Hose
    15119, -- Cleric's Pantaloons
    15120, -- Sorcerer's Tonban
    15121, -- Duelist's Tights
    15122, -- Assassin's Culottes
    15123, -- Valor Breeches
    15124, -- Abyss Flanchard
    15125, -- Monster Trousers
    15126, -- Bard's Cannions
    15127, -- Scout's Braccae
    15128, -- Saotome Haidate
    15129, -- Koga Hakama
    15130, -- Wyrm Brais
    15131, -- Summoner's Spats
    16346, -- Mirage Shalwar
    16349, -- Commodore Trews
    16352, -- Pantin Churidars
    13311, -- Heaven's Ring
    14630, -- Flame Ring
    14638, -- Thunder Ring
    14640, -- Snow Ring
    15294, -- Warwolf Belt
}

-- ============================================================================
-- W8: Feet
-- ============================================================================
local wardrobe8Items =
{
    12944, -- Scale Greaves
    12968, -- Kyahan
    12992, -- Solea
    12966, -- Bone Leggings
    12993, -- Sandals
    12975, -- Mercenary's Kyahan
    14151, -- Windurstian Kyahan
    15315, -- Shade Leggings
    15311, -- Noct Gaiters
    12950, -- Centurion's Greaves
    12982, -- Mercenary Captain's Gaiters
    12943, -- Royal Squire's Sollerets
    12998, -- Combat Caster's Shoes
    15663, -- Crow Gaiters
    12934, -- Iron Musketeer's Sabatons
    12942, -- Royal Knight's Sollerets
    15689, -- Jaridah Nails
    14129, -- Arhat's Sune-Ate
    14182, -- Errant Pigaches
    12946, -- Suzaku's Sune-Ate
    15662, -- Nashira Crackows
    15661, -- Homam Gambieras
    12957, -- Dusk Ledelsens
    14180, -- Hecatomb Leggings
    14123, -- Zenith Pumps
    14184, -- Shura Sune-Ate
    14160, -- Crimson Greaves
    12933, -- Koenig Schuhs
    13014, -- Leaping Boots
    13054, -- Fuma Kyahan
    15690, -- Yigit Crackows
    15711, -- Ares's Sollerets
    15715, -- Skadi's Jambeaux
    15719, -- Usukane Sune-Ate
    15723, -- Marduk's Crackows
    15727, -- Morrigan's Pigaches
    15733, -- Askar Gambieras
    15734, -- Denali Gamashes
    15735, -- Goliard Clogs
    14089, -- Fighter's Calligae
    14090, -- Temple Gaiters
    14091, -- Healer's Duckbills
    14092, -- Wizard's Sabots
    14093, -- Warlock's Boots
    14094, -- Rogue's Poulaines
    14095, -- Gallant Leggings
    14096, -- Chaos Sollerets
    14097, -- Beast Gaiters
    14098, -- Choral Slippers
    14099, -- Hunter's Socks
    14100, -- Myochin Sune-Ate
    14101, -- Ninja Kyahan
    14102, -- Drachen Greaves
    14103, -- Evoker's Pigaches
    15684, -- Magus Charuqs
    15685, -- Corsair's Bottes
    15686, -- Puppetry Babouches
    15132, -- Warrior's Calligae
    15133, -- Melee Gaiters
    15134, -- Cleric's Duckbills
    15135, -- Sorcerer's Sabots
    15136, -- Duelist's Boots
    15137, -- Assassin's Poulaines
    15138, -- Valor Leggings
    15139, -- Abyss Sollerets
    15140, -- Monster Gaiters
    15141, -- Bard's Slippers
    15142, -- Scout's Socks
    15143, -- Saotome Sune-Ate
    15144, -- Koga Kyahan
    15145, -- Wyrm Greaves
    15146, -- Summoner's Pigaches
    11382, -- Mirage Charuqs
    11385, -- Commodore Bottes
    11388, -- Pantin Babouches
}

-- ============================================================================
-- Inventory: Consumables
-- ============================================================================
local inventoryItems =
{
    { id = 4221, qty = 12 }, -- Beetle Arrow Quiver (x12)
    { id = 4222, qty = 12 }, -- Horn Arrow Quiver (x12)
    { id = 4223, qty = 12 }, -- Scorpion Arrow Quiver (x12)
    { id = 4224, qty = 12 }, -- Demon Arrow Quiver (x12)
    { id = 5334, qty = 12 }, -- Blind Bolt Quiver (x12)
    { id = 5335, qty = 12 }, -- Acid Bolt Quiver (x12)
    { id = 5337, qty = 12 }, -- Sleep Bolt Quiver (x12)
    { id = 5339, qty = 12 }, -- Bloody Bolt Quiver (x12)
    { id = 5336, qty = 12 }, -- Holy Bolt Quiver (x12)
    { id = 5363, qty = 12 }, -- Bullet Pouch (x12)
    { id = 5340, qty = 12 }, -- Silver Bullet Pouch (x12)
    { id = 5416, qty = 12 }, -- Steel Bullet Pouch (x12)
    { id = 4271, qty = 12 }, -- Rice Dumpling (x12)
    { id = 4578, qty = 12 }, -- Sausage (x12)
    { id = 5149, qty = 12 }, -- Sole Sushi (x12)
    { id = 4381, qty = 12 }, -- Meat Mithkabob (x12)
    { id = 5166, qty = 12 }, -- Coeurl Sub (x12)
    { id = 4394, qty = 99 }, -- Ginger Cookie (x99)
    { id = 4523, qty = 12 }, -- Melon Pie +1 (x12)
    { id = 5174, qty = 12 }, -- Tavnazian Taco (x12)
    { id = 4535, qty = 12 }, -- Boiled Crayfish (x12)
    { id = 4151, qty = 12 }, -- Echo Drops (x12)
}

-- ============================================================================
-- MODULE HOOK
-- ============================================================================

m:addOverride('xi.player.charCreate', function(player)
    super(player)

    -- Open all wardrobes and expand inventory
    player:changeContainerSize(xi.inv.WARDROBE,  80)
    player:changeContainerSize(xi.inv.WARDROBE2, 80)
    player:changeContainerSize(xi.inv.WARDROBE3, 80)
    player:changeContainerSize(xi.inv.WARDROBE4, 80)
    player:changeContainerSize(xi.inv.WARDROBE5, 80)
    player:changeContainerSize(xi.inv.WARDROBE6, 80)
    player:changeContainerSize(xi.inv.WARDROBE7, 80)
    player:changeContainerSize(xi.inv.WARDROBE8, 80)
    player:changeContainerSize(xi.inv.INVENTORY, 80)

    -- Populate wardrobes using addItemToContainer (registered by tester_gear.cpp)
    addGear(player, xi.inv.WARDROBE,  wardrobe1Items)
    addGear(player, xi.inv.WARDROBE2, wardrobe2Items)
    addGear(player, xi.inv.WARDROBE3, wardrobe3Items)
    addGear(player, xi.inv.WARDROBE4, wardrobe4Items)
    addGear(player, xi.inv.WARDROBE5, wardrobe5Items)
    addGear(player, xi.inv.WARDROBE6, wardrobe6Items)
    addGear(player, xi.inv.WARDROBE7, wardrobe7Items)
    addGear(player, xi.inv.WARDROBE8, wardrobe8Items)

    -- Add consumables to inventory
    addConsumables(player, inventoryItems)
end)
