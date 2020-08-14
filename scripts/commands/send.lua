---------------------------------------------------------------------------------------------------
-- func: send <player1> (<player2) or zone)
-- desc: Teleport a player to:
-- A) The given zone
-- B) another player
---------------------------------------------------------------------------------------------------
require("scripts/globals/zone")

cmdprops =
{
    permission = 1,
    parameters = "b"
}

---------------------------------------------------------------------------------------------------
-- desc: List of zones with their auto-translated group and message id.
-- note: The format is as follows: groupId, messageId, zoneId
---------------------------------------------------------------------------------------------------
local zone_list =
{
    { 0x14, 0xA9, 1 , 0, -2, 0}, -- Phanauet Channel
    { 0x14, 0xAA, 2 }, -- Carpenters' Landing
    { 0x14, 0x84, 3 }, -- Manaclipper
    { 0x14, 0x85, 4 }, -- Bibiki Bay
    { 0x14, 0x8A, 5 }, -- Uleguerand Range
    { 0x14, 0x8B, 6 }, -- Bearclaw Pinnacle
    { 0x14, 0x86, 7 }, -- Attohwa Chasm
    { 0x14, 0x87, 8 }, -- Boneyard Gully
    { 0x14, 0x88, 9 }, -- Pso'Xja
    { 0x14, 0x89, 10 }, -- The Shrouded Maw
    { 0x14, 0x8C, 11 }, -- Oldton Movalpolos
    { 0x14, 0x8D, 12 }, -- Newton Movalpolos
    { 0x14, 0x8E, 13 }, -- Mine Shaft #2716
    { 0x14, 0xDC, 13 }, -- Mine Shaft #2716
    { 0x14, 0xAB, 14 }, -- Hall of Transference
    { 0x14, 0x9B, 16 }, -- Promyvion - Holla
    { 0x14, 0x9A, 16 }, -- Promyvion - Holla
    { 0x14, 0x9C, 17 }, -- Spire of Holla
    { 0x14, 0x9E, 18 , 179, 0, -57}, -- Promyvion - Dem
    { 0x14, 0x9D, 18 , 179, 0, -57}, -- Promyvion - Dem
    { 0x14, 0x9F, 19 }, -- Spire of Dem
    { 0x14, 0xA0, 20 }, -- Promyvion - Mea
    { 0x14, 0xA1, 20 }, -- Promyvion - Mea
    { 0x14, 0xA2, 21 }, -- Spire of Mea
    { 0x14, 0xA3, 22 }, -- Promyvion - Vahzl
    { 0x14, 0xA4, 22 }, -- Promyvion - Vahzl
    { 0x14, 0xA5, 22 }, -- Promyvion - Vahzl
    { 0x14, 0xA6, 22 }, -- Promyvion - Vahzl
    { 0x14, 0xA7, 23 }, -- Spire of Vahzl
    { 0x14, 0xA8, 23 }, -- Spire of Vahzl
    { 0x14, 0x90, 24 }, -- Lufaise Meadows
    { 0x14, 0x91, 25 }, -- Misareaux Coast
    { 0x14, 0x8F, 26 }, -- Tavnazian Safehold
    { 0x14, 0x93, 27 }, -- Phomiuna Aqueducts
    { 0x14, 0x94, 28 }, -- Sacrarium
    { 0x14, 0x96, 29 }, -- Riverne - Site #B01
    { 0x14, 0x95, 29 }, -- Riverne - Site #B01
    { 0x14, 0x98, 30 }, -- Riverne - Site #A01
    { 0x14, 0x97, 30 }, -- Riverne - Site #A01
    { 0x14, 0x99, 31 }, -- Monarch Linn
    { 0x14, 0x92, 32 }, -- Sealion's Den
    { 0x14, 0xAC, 33 }, -- Al'Taieu
    { 0x14, 0xAD, 34 }, -- Grand Palace of Hu'Xzoi
    { 0x14, 0xAE, 35 }, -- The Garden of Ru'Hmet
    { 0x14, 0xB0, 36 }, -- Empyreal Paradox
    { 0x14, 0xB1, 37 }, -- Temenos
    { 0x14, 0xB2, 38 }, -- Apollyon
    { 0x14, 0xB4, 39 }, -- Dynamis - Valkurm
    { 0x14, 0xB5, 40 }, -- Dynamis - Buburimu
    { 0x14, 0xB6, 41 }, -- Dynamis - Qufim
    { 0x14, 0xB7, 42 }, -- Dynamis - Tavnazia
    { 0x14, 0xAF, 43 }, -- Diorama Abdhaljs-Ghelsba
    { 0x14, 0xB8, 44 }, -- Abdhaljs Isle-Purgonorgo
    { 0x14, 0xB9, 46 }, -- Open sea route to Al Zahbi
    { 0x14, 0xBA, 47 }, -- Open sea route to Mhaura
    { 0x14, 0xBB, 48 }, -- Al Zahbi
    { 0x14, 0xDB, 50 }, -- Aht Urhgan Whitegate
    { 0x14, 0xBC, 50 }, -- Aht Urhgan Whitegate
    { 0x14, 0xBD, 51 }, -- Wajaom Woodlands
    { 0x14, 0xBE, 52 }, -- Bhaflau Thickets
    { 0x14, 0xBF, 53 }, -- Nashmau
    { 0x14, 0xC0, 54 }, -- Arrapago Reef
    { 0x14, 0xC1, 55 }, -- Ilrusi Atoll
    { 0x14, 0xC2, 56 }, -- Periqia
    { 0x14, 0xC3, 57 }, -- Talacca Cove
    { 0x14, 0xC4, 58 , 0, -2, 0}, -- Silver Sea route to Nashmau
    { 0x14, 0xC5, 59 , 0, -2, 0}, -- Silver Sea route to Al Zahbi
    { 0x14, 0xC6, 60 }, -- The Ashu Talif
    { 0x14, 0xC7, 61 }, -- Mount Zhayolm
    { 0x14, 0xC8, 62 }, -- Halvung
    { 0x14, 0xC9, 63 }, -- Lebros Cavern
    { 0x14, 0xCA, 64 }, -- Navukgo Execution Chamber
    { 0x14, 0xCB, 65 }, -- Mamook
    { 0x14, 0xCC, 66 }, -- Mamool Ja Training Grounds
    { 0x14, 0xCD, 67 }, -- Jade Sepulcher
    { 0x14, 0xCE, 68 }, -- Aydeewa Subterrane
    { 0x14, 0xCF, 69 }, -- Leujaoam Sanctum
    { 0x27, 0x0F, 70 , -324, 0, -473}, -- Chocobo Circuit
    { 0x27, 0x10, 71 }, -- The Colosseum
    { 0x14, 0xDD, 72 }, -- Alzadaal Undersea Ruins
    { 0x14, 0xDE, 73 }, -- Zhayolm Remnants
    { 0x14, 0xDF, 74 }, -- Arrapago Remnants
    { 0x14, 0xE0, 75 }, -- Bhaflau Remnants
    { 0x14, 0xE1, 76 }, -- Silver Sea Remnants
    { 0x14, 0xE2, 77 }, -- Nyzul Isle
    { 0x14, 0xDA, 78 }, -- Hazhalm Testing Grounds
    { 0x14, 0xD0, 79 }, -- Caedarva Mire
    { 0x27, 0x11, 80 }, -- Southern San d'Oria [S]
    { 0x27, 0x13, 81 }, -- East Ronfaure [S]
    { 0x27, 0x15, 82 }, -- Jugner Forest [S]
    { 0x27, 0x23, 83 }, -- Vunkerl Inlet [S]
    { 0x27, 0x17, 84 }, -- Batallia Downs [S]
    { 0x27, 0x3E, 85 }, -- La Vaule [S]
    { 0x27, 0x40, 85 }, -- La Vaule [S]
    { 0x27, 0x19, 86 }, -- Everbloom Hollow
    { 0x27, 0x1C, 87 }, -- Bastok Markets [S]
    { 0x27, 0x1E, 88 }, -- North Gustaberg [S]
    { 0x27, 0x20, 89 }, -- Grauberg [S]
    { 0x27, 0x25, 90 }, -- Pashhow Marshlands [S]
    { 0x27, 0x27, 91 }, -- Rolanberry Fields [S]
    { 0x27, 0x42, 92 }, -- Beadeaux [S]
    { 0x27, 0x22, 93 }, -- Ruhotz Silvermines
    { 0x27, 0x2B, 94 }, -- Windurst Waters [S]
    { 0x27, 0x2D, 95 }, -- West Sarutabaruta [S]
    { 0x27, 0x2F, 96 }, -- Fort Karugo-Narugo [S]
    { 0x27, 0x32, 97 }, -- Meriphataud Mountains [S]
    { 0x27, 0x34, 98 }, -- Sauromugue Champaign [S]
    { 0x27, 0x44, 99 }, -- Castle Oztroja [S]
    { 0x14, 0x11, 100 }, -- West Ronfaure
    { 0x14, 0x0F, 101 }, -- East Ronfaure
    { 0x14, 0x51, 102 }, -- La Theine Plateau
    { 0x14, 0x60, 103 }, -- Valkurm Dunes
    { 0x14, 0x01, 104 }, -- Jugner Forest
    { 0x14, 0x02, 105 }, -- Batallia Downs
    { 0x14, 0x64, 106 }, -- North Gustaberg
    { 0x14, 0x63, 107 }, -- South Gustaberg
    { 0x14, 0x69, 108 }, -- Konschtat Highlands
    { 0x14, 0x2B, 109 }, -- Pashhow Marshlands
    { 0x14, 0x07, 110 }, -- Rolanberry Fields
    { 0x14, 0x24, 111 }, -- Beaucedine Glacier
    { 0x14, 0x4D, 112 }, -- Xarcabard
    { 0x14, 0x3D, 113 }, -- Cape Teriggan
    { 0x14, 0x3E, 114 }, -- Eastern Altepa Desert
    { 0x14, 0x18, 115 }, -- West Sarutabaruta
    { 0x14, 0x27, 116 }, -- East Sarutabaruta
    { 0x14, 0x17, 117 }, -- Tahrongi Canyon
    { 0x14, 0x16, 118 }, -- Buburimu Peninsula
    { 0x14, 0x20, 119 }, -- Meriphataud Mountains
    { 0x14, 0x2E, 120 }, -- Sauromugue Champaign
    { 0x14, 0x3F, 121 }, -- The Sanctuary of Zi'Tah
    { 0x14, 0x7D, 122 }, -- Ro'Maeve
    { 0x14, 0x7C, 122 }, -- Ro'Maeve
    { 0x14, 0x40, 123 }, -- Yuhtunga Jungle
    { 0x14, 0x41, 124 }, -- Yhoator Jungle
    { 0x14, 0x42, 125 }, -- Western Altepa Desert
    { 0x14, 0x08, 126 }, -- Qufim Island
    { 0x14, 0x0A, 127 }, -- Behemoth's Dominion
    { 0x14, 0x43, 128 }, -- Valley of Sorrows
    { 0x27, 0x31, 129 }, -- Ghoyu's Reverie
    { 0x14, 0x6F, 130 }, -- Ru'Aun Gardens
    { 0x14, 0x82, 134 }, -- Dynamis - Beaucedine
    { 0x14, 0x83, 135 }, -- Dynamis - Xarcabard
    { 0x27, 0x46, 136 }, -- Beaucedine Glacier [S]
    { 0x27, 0x48, 137 }, -- Xarcabard [S]
    { 0x14, 0x65, 139 }, -- Horlais Peak
    { 0x14, 0x6C, 140 }, -- Ghelsba Outpost
    { 0x14, 0x1F, 141 }, -- Fort Ghelsba
    { 0x14, 0x5E, 142 }, -- Yughott Grotto
    { 0x14, 0x66, 143 }, -- Palborough Mines
    { 0x14, 0x1A, 144 }, -- Waughroon Shrine
    { 0x14, 0x21, 145 }, -- Giddeus
    { 0x14, 0x19, 146 }, -- Balga's Dais
    { 0x14, 0x2A, 147 }, -- Beadeaux
    { 0x14, 0x28, 148 }, -- Qulun Dome
    { 0x14, 0x68, 149 }, -- Davoi
    { 0x14, 0x6D, 150 }, -- Monastic Cavern
    { 0x14, 0x23, 151 }, -- Castle Oztroja
    { 0x14, 0x04, 152 }, -- Altar Room
    { 0x14, 0x44, 153 }, -- The Boyahda Tree
    { 0x14, 0x37, 154 }, -- Dragon's Aery
    { 0x14, 0x0C, 157 }, -- Middle Delkfutt's Tower
    { 0x14, 0x0B, 158 }, -- Upper Delkfutt's Tower
    { 0x14, 0x36, 159 }, -- Temple of Uggalepih
    { 0x14, 0x35, 160 }, -- Den of Rancor
    { 0x14, 0x26, 161 }, -- Castle Zvahl Baileys
    { 0x14, 0x25, 161 }, -- Castle Zvahl Baileys
    { 0x14, 0x50, 162 }, -- Castle Zvahl Keep
    { 0x14, 0x4F, 162 }, -- Castle Zvahl Keep
    { 0x14, 0x39, 163 }, -- Sacrificial Chamber
    { 0x27, 0x36, 164 }, -- Garlaige Citadel [S]
    { 0x14, 0x5D, 165 }, -- Throne Room
    { 0x14, 0x2D, 166 }, -- Ranguemont Pass
    { 0x14, 0x32, 167 }, -- Bostaunieux Oubliette
    { 0x14, 0x3B, 168 }, -- Chamber of Oracles
    { 0x14, 0x1D, 169 }, -- Toraimarai Canal
    { 0x14, 0x5C, 170 }, -- Full Moon Fountain
    { 0x27, 0x29, 171 }, -- Crawlers' Nest [S]
    { 0x14, 0x61, 172 }, -- Zeruhn Mines
    { 0x14, 0x5B, 173 }, -- Korroloka Tunnel
    { 0x14, 0x5A, 174 }, -- Kuftal Tunnel
    { 0x27, 0x1A, 175 }, -- The Eldieme Necropolis [S]
    { 0x14, 0x59, 176 }, -- Sea Serpent Grotto
    { 0x14, 0x71, 177 }, -- Ve'Lugannon Palace
    { 0x14, 0x70, 177 }, -- Ve'Lugannon Palace
    { 0x14, 0x72, 178 }, -- The Shrine of Ru'Avitau
    { 0x14, 0xB3, 179 }, -- Stellar Fulcrum
    { 0x14, 0x73, 180 }, -- La'Loff Amphitheater
    { 0x14, 0x74, 181 }, -- The Celestial Nexus
    { 0x14, 0x0D, 184 }, -- Lower Delkfutt's Tower
    { 0x14, 0x7E, 185 }, -- Dynamis - San d'Oria
    { 0x14, 0x7F, 186 }, -- Dynamis - Bastok
    { 0x14, 0x80, 187 }, -- Dynamis - Windurst
    { 0x14, 0x81, 188 }, -- Dynamis - Jeuno
    { 0x14, 0x6E, 190 }, -- King Ranperre's Tomb
    { 0x14, 0x62, 191 }, -- Dangruf Wadi
    { 0x14, 0x1C, 192 }, -- Inner Horutoto Ruins
    { 0x14, 0x03, 193 }, -- Ordelle's Caves
    { 0x14, 0x1B, 194 }, -- Outer Horutoto Ruins
    { 0x14, 0x6A, 195 }, -- The Eldieme Necropolis
    { 0x14, 0x67, 196 }, -- Gusgen Mines
    { 0x14, 0x2C, 197 }, -- Crawlers' Nest
    { 0x14, 0x15, 198 }, -- Maze of Shakhrami
    { 0x14, 0x14, 200 }, -- Garlaige Citadel
    { 0x14, 0x77, 201 }, -- Cloister of Gales
    { 0x14, 0x75, 202 }, -- Cloister of Storms
    { 0x14, 0x7A, 203 }, -- Cloister of Frost
    { 0x14, 0x4A, 204 }, -- Fei'Yin
    { 0x14, 0x58, 205 }, -- Ifrit's Cauldron
    { 0x14, 0x6B, 206 }, -- Qu'Bia Arena
    { 0x14, 0x78, 207 }, -- Cloister of Flames
    { 0x14, 0x57, 208 }, -- Quicksand Caves
    { 0x14, 0x76, 209 }, -- Cloister of Tremors
    { 0x14, 0x79, 211 }, -- Cloister of Tides
    { 0x14, 0x34, 212 }, -- Gustav Tunnel
    { 0x14, 0x33, 213 }, -- Labyrinth of Onzozo
    { 0x14, 0x4C, 230 }, -- Southern San d'Oria
    { 0x14, 0x30, 231 }, -- Northern San d'Oria
    { 0x14, 0x52, 232 }, -- Port San d'Oria
    { 0x14, 0x22, 233 }, -- Chateau d'Oraguille
    { 0x14, 0x46, 234 }, -- Bastok Mines
    { 0x14, 0x56, 235 }, -- Bastok Markets
    { 0x14, 0x3C, 236 }, -- Port Bastok
    { 0x14, 0x2F, 237 }, -- Metalworks
    { 0x14, 0x3A, 238 }, -- Windurst Waters
    { 0x14, 0x54, 239 }, -- Windurst Walls
    { 0x14, 0x45, 240 }, -- Port Windurst
    { 0x14, 0x38, 241 }, -- Windurst Woods
    { 0x14, 0x55, 242 }, -- Heavens Tower
    { 0x14, 0x13, 243 }, -- Ru'Lude Gardens
    { 0x14, 0x4E, 244 }, -- Upper Jeuno
    { 0x14, 0x0E, 245 }, -- Lower Jeuno
    { 0x14, 0x06, 246 }, -- Port Jeuno
    { 0x14, 0x31, 247 }, -- Rabao
    { 0x14, 0x5F, 248 }, -- Selbina
    { 0x14, 0x1E, 249 }, -- Mhaura
    { 0x14, 0x29, 250 }, -- Kazham
    { 0x14, 0x7B, 251 }, -- Hall of the Gods
    { 0x14, 0x09, 252 }, -- Norg
    { 0x27, 0x4C, 256 }, -- Western Adoulin
    { 0x27, 0x4D, 257 }, -- Eastern Adoulin
    { 0x27, 0x4E, 259 }, -- Rala Waterways [U]
    { 0x27, 0x4F, 260 }, -- Yahse Hunting Grounds
    { 0x27, 0x50, 261 }, -- Ceizak Battlegrounds
    { 0x27, 0x51, 262 }, -- Foret de Hennetiel
    { 0x27, 0x56, 264 }, -- Yorcia Weald [U]
    { 0x27, 0x52, 265 }, -- Morimar Basalt Fields
    { 0x27, 0x57, 266 }, -- Marjami Ravine
    { 0x27, 0x5C, 267 }, -- Kamihr Drifts
    { 0x27, 0x53, 268 }, -- Sih Gates
    { 0x27, 0x54, 269 }, -- Moh Gates
    { 0x27, 0x55, 271 }, -- Cirdas Caverns [U]
    { 0x27, 0x58, 272 }, -- Dho Gates
    { 0x27, 0x5D, 273 }, -- Woh Gates
    { 0x27, 0x12, 275 }, -- Outer Ra'Kaznar [U]
    { 0x27, 0x5A, 280 }, -- Mog Garden
    { 0x27, 0x59, 284 }, -- Celennia Memorial Library
    { 0x27, 0x5B, 285 }, -- Feretory
    { 0x14, 0x09, 288 }, -- Escha - Zi'Tah
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!send <player to send> <destination player or zone>")
end

function getBytePos(s, needle)
    local i
    local b
    for i=1, string.len(s), 1 do
        if (string.byte(s, i) == needle) then
            return i
        end
    end
    return nil
end

---------------------------------------------------------------------------------------------------
-- func: onTrigger
-- desc: Called when this command is invoked.
---------------------------------------------------------------------------------------------------
function onTrigger(player, bytes)
    local x = 0
    local y = 0
    local z = 0
    local rot = 0
    local zone

    if (bytes == nil) then
        error(player, "You must provide the name of a player to send and a destination.")
        return
    end
    bytes = string.sub(bytes, 6)
    local atpos = getBytePos(bytes, 253)
    local sppos = getBytePos(bytes, 32)

    -- validate player to send
    local target
    local targ
    if (sppos == nil) then
        error(player, "You must provide the name of a player to send and a destination.")
        return
    else
        target = string.sub(bytes, 1, sppos-1)
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format( "Player named '%s' not found!", target ))
            return
        end
    end

    -- validate destination
    if (atpos ~= nil) then
        -- destination is an auto-translate phrase
        local groupId = string.byte(bytes, atpos + 3)
        local messageId = string.byte(bytes, atpos + 4)
        for k, v in pairs(zone_list) do
            if (v[1] == groupId and v[2] == messageId) then
                x = v[4] or 0
                y = v[5] or 0
                z = v[6] or 0
                rot = 0
                zone = v[3]
                break
            end
        end
        if (zone == nil) then
            error(player, "Auto-translated phrase is not a zone.")
            return
        end
    else
        local dest = string.sub(bytes, sppos+1)
        if (tonumber(dest) ~= nil) then
            -- destination is a zone ID.
            zone = tonumber(dest)
            if (zone < 0 or zone >= tpz.zone.MAX_ZONE) then
                error(player, "Invalid zone ID.")
                return
            end
            for k, v in pairs(zone_list) do
                if (v[3] == zone) then
                    x = v[4] or 0
                    y = v[5] or 0
                    z = v[6] or 0
                    rot = 0
                    zone = v[3]
                    break
                end
            end
        else
            -- destination is a player name.
            local target = dest
            dest = GetPlayerByName(dest)
            if (dest == nil) then
                error(player, string.format( "Player named '%s' not found!", target ))
                return
            end
            x = dest:getXPos()
            y = dest:getYPos()
            z = dest:getZPos()
            rot = dest:getRotPos()
            zone = dest:getZoneID()
        end
    end

    -- send target to destination
    targ:setPos(x, y, z, rot, zone)
    if (targ:getID() ~= player:getID()) then
        player:PrintToPlayer( string.format("Sent %s to zone %i.", targ:getName(), zone) )
    end
end

