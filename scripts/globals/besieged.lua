-----------------------------------
-- Functions for Besieged system
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/teleports')
require('scripts/globals/extravaganza')
-----------------------------------
xi = xi or {}
xi.besieged = xi.besieged or {}

xi.besieged.cipherValue = function()
    local active = xi.extravaganza.campaignActive()

    if
        active == xi.extravaganza.campaign.SUMMER_NY or
        active == xi.extravaganza.campaign.BOTH
    then
        return 65536 * 16384
    else
        return 0
    end
end

local function getMapBitmask(player)
    local mamook   = player:hasKeyItem(xi.ki.MAP_OF_MAMOOK) and 1 or 0 -- Map of Mammok
    local halvung  = player:hasKeyItem(xi.ki.MAP_OF_HALVUNG) and 2 or 0 -- Map of Halvung
    local arrapago = player:hasKeyItem(xi.ki.MAP_OF_ARRAPAGO_REEF) and 4 or 0 -- Map of Arrapago Reef
    local astral   = bit.lshift(xi.besieged.getAstralCandescence(), 31) -- Include astral candescence in the top byte

    return bit.bor(mamook, halvung, arrapago, astral)
end

-----------------------------------
-- function getImperialDefenseStats() returns:
-- *how many successive times Al Zahbi has been defended
-- *Imperial Defense Value
-- *Total number of imperial victories
-- *Total number of beastmen victories.
-- hardcoded constants for now until we have a Besieged system.
-----------------------------------
local function getImperialDefenseStats()
    local successiveWins = 0
    local defenseBonus = 0
    local imperialWins = 0
    local beastmanWins = 0
    return { successiveWins, defenseBonus, imperialWins, beastmanWins }
end

-----------------------------------
-- function getISPItem(i) returns the item ID and cost of the imperial standing
-- points item indexed by i (the same value  as that used by the vendor event.)
-- TODO: Separate packed data into something more logical
-----------------------------------
local function getISPItem(i)
    ---@class imperialStandingItems : { [integer]: { id: xi.item, price: integer } }
    local imperialStandingItems =
    {
        -- Common Items
        [    1] = { id = xi.item.SCROLL_OF_INSTANT_RERAISE,  price =     7 },
        [ 4097] = { id = xi.item.SCROLL_OF_INSTANT_WARP,     price =    10 },
        [ 8193] = { id = xi.item.LAMBENT_FIRE_CELL,          price =   100 },
        [12289] = { id = xi.item.LAMBENT_WATER_CELL,         price =   100 },
        [16385] = { id = xi.item.LAMBENT_EARTH_CELL,         price =   100 },
        [20481] = { id = xi.item.LAMBENT_WIND_CELL,          price =   100 },
        [24577] = { id = xi.item.KATANA_STRAP,               price = 20000 },
        [28673] = { id = xi.item.AXE_GRIP,                   price = 20000 },
        [32769] = { id = xi.item.STAFF_STRAP,                price = 20000 },
        [36865] = { id = xi.item.HEAT_CAPACITOR,             price =  5000 },
        [40961] = { id = xi.item.POWER_COOLER,               price =  5000 },
        [45057] = { id = xi.item.BARRAGE_TURBINE,            price =  5000 },
        [53249] = { id = xi.item.GALVANIZER,                 price =  5000 },
        [57345] = { id = xi.item.EPHRAMADIAN_THRONE,         price = 50000 },
        [69633] = { id = xi.item.CIPHER_OF_MIHLIS_ALTER_EGO, price =  5000 },

        -- Private Second Class
        -- Map Key Items (handled separately)
        -- Private First Class
        [ 33] = { id = xi.item.VOLUNTEERS_DART, price = 2000 },
        [289] = { id = xi.item.MERCENARYS_DART, price = 2000 },
        [545] = { id = xi.item.IMPERIAL_DART,   price = 2000 },

        -- Superior Private
        [ 49] = { id = xi.item.MAMOOLBANE,  price = 4000 },
        [305] = { id = xi.item.LAMIABANE,   price = 4000 },
        [561] = { id = xi.item.TROLLBANE,   price = 4000 },
        [817] = { id = xi.item.LUZAFS_RING, price = 4000 },

        -- Lance Corporal
        [ 65] = { id = xi.item.SNEAKING_BOOTS,  price = 8000 },
        [321] = { id = xi.item.TROOPERS_RING,   price = 8000 },
        [577] = { id = xi.item.SENTINEL_SHIELD, price = 8000 },

        -- Corporal
        [ 81] = { id = xi.item.SHARK_GUN,    price = 16000 },
        [337] = { id = xi.item.PUPPET_CLAWS, price = 16000 },
        [593] = { id = xi.item.SINGH_KILIJ,  price = 16000 },

        -- Sergeant
        [ 97] = { id = xi.item.MERCENARYS_TROUSERS, price = 24000 },
        [353] = { id = xi.item.MULTIPLE_RING,       price = 24000 },
        [609] = { id = xi.item.HATEN_EARRING,       price = 24000 },

        -- Sergeant Major
        [113] = { id = xi.item.VOLUNTEERS_BRAIS, price = 32000 },
        [369] = { id = xi.item.PRIESTS_EARRING,  price = 32000 },
        [625] = { id = xi.item.CHAOTIC_EARRING,  price = 32000 },

        -- Chief Sergeant
        [129] = { id = xi.item.PERDU_HANGER, price = 40000 },
        [385] = { id = xi.item.PERDU_SICKLE, price = 40000 },
        [641] = { id = xi.item.PERDU_WAND,   price = 40000 },
        [897] = { id = xi.item.PERDU_BOW,    price = 40000 },

        -- Second Lieutenant
        [ 145] = { id = xi.item.PERDU_SWORD,    price = 48000 },
        [ 401] = { id = xi.item.PERDU_BLADE,    price = 48000 },
        [ 657] = { id = xi.item.PERDU_VOULGE,   price = 48000 },
        [ 913] = { id = xi.item.PERDU_STAFF,    price = 48000 },
        [1169] = { id = xi.item.PERDU_CROSSBOW, price = 48000 },

        -- First Lieutenant
        [161] = { id = xi.item.LIEUTENANTS_GORGET, price = 56000 },
        [417] = { id = xi.item.LIEUTENANTS_SASH,   price = 56000 },
        [673] = { id = xi.item.LIEUTENANTS_CAPE,   price = 56000 },
    }

    local item = imperialStandingItems[i]
    if item then
        return item.id, item.price
    end

    return nil
end

-----------------------------------
-- function getSanctionDuration(player) returns the duration of the sanction effect
-- in seconds. Duration is known to go up with mercenary rank but data published on
-- ffxi wiki (http://wiki.ffxiclopedia.org/wiki/Sanction) is unclear and even
-- contradictory (the page on the AC http://wiki.ffxiclopedia.org/wiki/Astral_Candescence
-- says that duration is 3-8 hours with the AC, 1-3 hours without the AC while the Sanction
-- page says it's 3-6 hours with th AC.)
--
-- I decided to use the formula duration (with AC) = 3 hours + (mercenary rank - 1) * 20 minutes.
-----------------------------------
local function getSanctionDuration(player)
    local duration = 10800 + 1200 * (xi.besieged.getMercenaryRank(player) - 1)

    if xi.besieged.getAstralCandescence() == 0 then
        duration = duration / 2
    end

    return duration
end

xi.besieged.onTrigger = function(player, npc, eventBase)
    local mercRank = xi.besieged.getMercenaryRank(player)
    if mercRank == 0 then
        player:startEvent(eventBase + 1, npc)
    else
        local maps = getMapBitmask(player)
        player:startEvent(eventBase, player:getCurrency('imperial_standing'), (maps + xi.besieged.cipherValue()), mercRank, 0, unpack(getImperialDefenseStats()))
    end
end

xi.besieged.onEventUpdate = function(player, csid, option, npc)
    local itemId = getISPItem(option)
    if itemId and option < 0x40000000 then
        local maps = getMapBitmask(player)
        player:updateEvent(player:getCurrency('imperial_standing'), (maps + xi.besieged.cipherValue()), xi.besieged.getMercenaryRank(player), player:canEquipItem(itemId) and 2 or 1, unpack(getImperialDefenseStats()))
    end
end

xi.besieged.onEventFinish = function(player, csid, option, npc)
    local ID = zones[player:getZoneID()]
    if option == 0 or option == 16 or option == 32 or option == 48 then
        -- Sanction
        if option ~= 0 then
            player:delCurrency('imperial_standing', 100)
        end

        player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
        local duration = getSanctionDuration(player)
        local subPower = 0 -- getImperialDefenseStats()
        player:addStatusEffect(xi.effect.SANCTION, option / 16, 0, duration, subPower)
        player:messageSpecial(ID.text.SANCTION)
    elseif bit.band(option, 0xFF) == 17 then
        -- Player bought a map
        local ki = xi.ki.MAP_OF_MAMOOK + bit.rshift(option, 8)
        npcUtil.giveKeyItem(player, ki)
        player:delCurrency('imperial_standing', 1000)
    elseif option < 0x40000000 then
        -- Player bought an item
        local item, price = getISPItem(option)
        if item then
            if npcUtil.giveItem(player, item) then
                player:delCurrency('imperial_standing', price)
            end
        end
    end
end

-----------------------------------
-- Variable for addTeleport and getRegionPoint
-----------------------------------
xi.besieged.addRunicPortal = function(player, portal)
    player:addTeleport(xi.teleport.type.RUNIC_PORTAL, portal)
end

xi.besieged.hasRunicPortal = function(player, portal)
    return player:hasTeleport(xi.teleport.type.RUNIC_PORTAL, portal)
end

xi.besieged.hasAssaultOrders = function(player)
    local event = 0
    local keyitem = 0

    for i = 0, 4 do
        local ki = xi.ki.LEUJAOAM_ASSAULT_ORDERS + i
        if player:hasKeyItem(ki) then
            event = 120 + i
            keyitem = ki
            break
        end
    end

    return event, keyitem
end

-- TODO: Implement Astral Candescence
xi.besieged.getAstralCandescence = function()
    return 1 -- Hardcoded to 1 for now
end

xi.besieged.badges =
{
    xi.ki.PSC_WILDCAT_BADGE,
    xi.ki.PFC_WILDCAT_BADGE,
    xi.ki.SP_WILDCAT_BADGE,
    xi.ki.LC_WILDCAT_BADGE,
    xi.ki.C_WILDCAT_BADGE,
    xi.ki.S_WILDCAT_BADGE,
    xi.ki.SM_WILDCAT_BADGE,
    xi.ki.CS_WILDCAT_BADGE,
    xi.ki.SL_WILDCAT_BADGE,
    xi.ki.FL_WILDCAT_BADGE,
    xi.ki.CAPTAIN_WILDCAT_BADGE
}

xi.besieged.getMercenaryRank = function(player)
    local rank = 0

    for k = #xi.besieged.badges, 1, -1 do
        if player:hasKeyItem(xi.besieged.badges[k]) then
            rank = k
            break
        end
    end

    return rank
end
