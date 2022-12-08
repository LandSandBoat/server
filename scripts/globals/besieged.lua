-----------------------------------
--
--     Functions for Besieged system
--
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/status')
require('scripts/globals/teleports')
require('scripts/globals/settings')
require('scripts/globals/items')
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
-- TODO: Format table, use xi.items enum, and descriptive parameter name
-----------------------------------
local function getISPItem(i)
    local imperialStandingItems =
    {
        -- Common Items
        [1] = { id = 4182, price = 7 }, -- scroll of Instant Reraise
        [4097] = { id = 4181, price = 10 }, -- scroll of Instant Warp
        [8193] = { id = 2230, price = 100 }, -- lambent fire cell
        [12289] = { id = 2231, price = 100 }, -- lambent water cell
        [16385] = { id = 2232, price = 100 }, -- lambent earth cell
        [20481] = { id = 2233, price = 100 }, -- lambent wind cell
        [24577] = { id = 19021, price = 20000 }, -- katana strap
        [28673] = { id = 19022, price = 20000 }, -- axe grip
        [32769] = { id = 19023, price = 20000 }, -- staff strap
        [36865] = { id = 3307, price = 5000 }, -- heat capacitor
        [40961] = { id = 3308, price = 5000 }, -- power cooler
        [45057] = { id = 3309, price = 5000 }, -- barrage turbine
        [53249] = { id = 3311, price = 5000 }, -- galvanizer
        [57345] = { id = 6409, price = 50000 },
        [69633] = { id = xi.items.CIPHER_OF_MIHLIS_ALTER_EGO, price = 5000 }, -- mihli
        -- Private Second Class
        -- Map Key Items (handled separately)
        -- Private First Class
        [33] = { id = 18689, price = 2000 }, -- volunteer's dart
        [289] = { id = 18690, price = 2000 }, -- mercenary's dart
        [545] = { id = 18691, price = 2000 }, -- Imperial dart
        -- Superior Private
        [49] = { id = 18692, price = 4000 }, -- Mamoolbane
        [305] = { id = 18693, price = 4000 }, -- Lamiabane
        [561] = { id = 18694, price = 4000 }, -- Trollbane
        [817] = { id = 15810, price = 4000 }, -- Luzaf's ring
        -- Lance Corporal
        [65] = { id = 15698, price = 8000 }, -- sneaking boots
        [321] = { id = 15560, price = 8000 }, -- trooper's ring
        [577] = { id = 16168, price = 8000 }, -- sentinel shield
        -- Corporal
        [81] = { id = 18703, price = 16000 }, -- shark gun
        [337] = { id = 18742, price = 16000 }, -- puppet claws
        [593] = { id = 17723, price = 16000 }, -- singh kilij
        -- Sergeant
        [97] = { id = 15622, price = 24000 }, -- mercenary's trousers
        [353] = { id = 15790, price = 24000 }, -- multiple ring
        [609] = { id = 15981, price = 24000 }, -- haten earring
        -- Sergeant Major
        [113] = { id = 15623, price = 32000 }, -- volunteer's brais
        [369] = { id = 15982, price = 32000 }, -- priest's earring
        [625] = { id = 15983, price = 32000 }, -- chaotic earring
        -- Chief Sergeant
        [129] = { id = 17741, price = 40000 }, -- perdu hanger
        [385] = { id = 18943, price = 40000 }, -- perdu sickle
        [641] = { id = 18850, price = 40000 }, -- perdu wand
        [897] = { id = 18717, price = 40000 }, -- perdu bow
        -- Second Lieutenant
        [145] = { id = 16602, price = 48000 }, -- perdu sword
        [401] = { id = 18425, price = 48000 }, -- perdu blade
        [657] = { id = 18491, price = 48000 }, -- perdu voulge
        [913] = { id = 18588, price = 48000 }, -- perdu staff
        [1169] = { id = 18718, price = 48000 }, -- perdu crossbow
        -- First Lieutenant
        [161] = { id = 16271, price = 56000 }, -- lieutenant's gorget
        [417] = { id = 15912, price = 56000 }, -- lieutenant's sash
        [673] = { id = 16230, price = 56000 } -- lieutenant's cape
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
        player:startEvent(eventBase, player:getCurrency("imperial_standing"), (maps + xi.besieged.cipherValue()), mercRank, 0, unpack(getImperialDefenseStats()))
    end
end

xi.besieged.onEventUpdate = function(player, csid, option)
    local itemId = getISPItem(option)
    if itemId and option < 0x40000000 then
        local maps = getMapBitmask(player)
        player:updateEvent(player:getCurrency("imperial_standing"), (maps + xi.besieged.cipherValue()), xi.besieged.getMercenaryRank(player), player:canEquipItem(itemId) and 2 or 1, unpack(getImperialDefenseStats()))
    end
end

xi.besieged.onEventFinish = function(player, csid, option)
    local ID = zones[player:getZoneID()]
    if option == 0 or option == 16 or option == 32 or option == 48 then
        -- Sanction
        if option ~= 0 then
            player:delCurrency("imperial_standing", 100)
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
        player:delCurrency("imperial_standing", 1000)
    elseif option < 0x40000000 then
        -- Player bought an item
        local item, price = getISPItem(option)
        if item then
            if npcUtil.giveItem(player, item) then
                player:delCurrency("imperial_standing", price)
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
