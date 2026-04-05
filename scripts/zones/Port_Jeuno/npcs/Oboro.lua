-----------------------------------
-- Area: Port Jeuno (246)
--  NPC: Oboro
-- Type: Relic/Mythic/Empyrean Weapon Reforging NPC
-- !pos -180.000 11.000 86.000 246
-- Trades lv90 weapon + 300 upgrade materials
-- to produce iLvl 119 version
-----------------------------------
---@type TNpcEntity
local entity = {}

local materialQty = 300

-- Relic weapons: trade lv90 weapon + 300 Plutons -> iLvl 119
local relicMap =
{
    [xi.item.SPHARAI_90]        = xi.item.SPHARAI_119,
    [xi.item.MANDAU_90]         = xi.item.MANDAU_119,
    [xi.item.EXCALIBUR_90]      = xi.item.EXCALIBUR_119,
    [xi.item.RAGNAROK_90]       = xi.item.RAGNAROK_119,
    [xi.item.GUTTLER_90]        = xi.item.GUTTLER_119,
    [xi.item.BRAVURA_90]        = xi.item.BRAVURA_119,
    [xi.item.GUNGNIR_90]        = xi.item.GUNGNIR_119,
    [xi.item.APOCALYPSE_90]     = xi.item.APOCALYPSE_119,
    [xi.item.KIKOKU_90]         = xi.item.KIKOKU_119,
    [xi.item.AMANOMURAKUMO_90]  = xi.item.AMANOMURAKUMO_119,
    [xi.item.MJOLLNIR_90]       = xi.item.MJOLLNIR_119,
    [xi.item.CLAUSTRUM_90]      = xi.item.CLAUSTRUM_119,
    [xi.item.ANNIHILATOR_90]    = xi.item.ANNIHILATOR_119,
    [xi.item.YOICHINOYUMI_90]   = xi.item.YOICHINOYUMI_119,
}

-- Mythic weapons: trade lv90 weapon + 300 Beitetsu -> iLvl 119
local mythicMap =
{
    [xi.item.CONQUEROR_90]      = xi.item.CONQUEROR_119,
    [xi.item.GLANZFAUST_90]     = xi.item.GLANZFAUST_119,
    [xi.item.YAGRUSH_90]        = xi.item.YAGRUSH_119,
    [xi.item.LAEVATEINN_90]     = xi.item.LAEVATEINN_119,
    [xi.item.MURGLEIS_90]       = xi.item.MURGLEIS_119,
    [xi.item.VAJRA_90]          = xi.item.VAJRA_119,
    [xi.item.BURTGANG_90]       = xi.item.BURTGANG_119,
    [xi.item.LIBERATOR_90]      = xi.item.LIBERATOR_119,
    [xi.item.AYMUR_90]          = xi.item.AYMUR_119,
    [xi.item.CARNWENHAN_90]     = xi.item.CARNWENHAN_119,
    [xi.item.GASTRAPHETES_90]   = xi.item.GASTRAPHETES_119,
    [xi.item.KOGARASUMARU_90]   = xi.item.KOGARASUMARU_119,
    [xi.item.NAGI_90]           = xi.item.NAGI_119,
    [xi.item.RYUNOHIGE_90]      = xi.item.RYUNOHIGE_119,
    [xi.item.NIRVANA_90]        = xi.item.NIRVANA_119,
    [xi.item.TIZONA_90]         = xi.item.TIZONA_119,
    [xi.item.DEATH_PENALTY_90]  = xi.item.DEATH_PENALTY_119,
    [xi.item.KENKONKEN_90]      = xi.item.KENKONKEN_119,
    [xi.item.TERPSICHORE_90]    = xi.item.TERPSICHORE_119,
    [xi.item.TUPSIMATI_90]      = xi.item.TUPSIMATI_119,
}

-- Empyrean weapons: trade lv90 weapon + 300 Riftborn Boulders -> iLvl 119
local empyreanMap =
{
    [xi.item.VERETHRAGNA_90]    = xi.item.VERETHRAGNA_119_III,
    [xi.item.TWASHTAR_90]       = xi.item.TWASHTAR_119_III,
    [xi.item.ALMACE_90]         = xi.item.ALMACE_119_III,
    [xi.item.CALADBOLG_90]      = xi.item.CALADBOLG_119_III,
    [xi.item.FARSHA_90]         = xi.item.FARSHA_119_III,
    [xi.item.UKONVASARA_90]     = xi.item.UKONVASARA_119_III,
    [xi.item.REDEMPTION_90]     = xi.item.REDEMPTION_119_III,
    [xi.item.RHONGOMIANT_90]    = xi.item.RHONGOMIANT_119_III,
    [xi.item.KANNAGI_90]        = xi.item.KANNAGI_119_III,
    [xi.item.MASAMUNE_90]       = xi.item.MASAMUNE_119_III,
    [xi.item.GAMBANTEINN_90]    = xi.item.GAMBANTEINN_119_III,
    [xi.item.HVERGELMIR_90]     = xi.item.HVERGELMIR_119_III,
    [xi.item.GANDIVA_90]        = xi.item.GANDIVA_119_III,
    [xi.item.ARMAGEDDON_90]     = xi.item.ARMAGEDDON_119_III,
}

local function tryReforge(player, trade, weaponMap, materialItem, category)
    for baseId, outputId in pairs(weaponMap) do
        if
            trade:hasItemQty(baseId, 1) and
            trade:hasItemQty(materialItem, materialQty) and
            trade:getItemCount() == 1 + materialQty
        then
            if npcUtil.giveItem(player, outputId) then
                player:confirmTrade()
                player:printToPlayer(string.format('Oboro: Your %s weapon has been reforged to iLvl 119!', category), xi.msg.channel.NS_SAY)
            end

            return true
        end
    end

    return false
end

entity.onTrade = function(player, npc, trade)
    if tryReforge(player, trade, relicMap, xi.item.PLUTON, 'Relic') then
        return
    end

    if tryReforge(player, trade, mythicMap, xi.item.BEITETSU, 'Mythic') then
        return
    end

    if tryReforge(player, trade, empyreanMap, xi.item.RIFTBORN_BOULDER, 'Empyrean') then
        return
    end
end

entity.onTrigger = function(player, npc)
    player:printToPlayer('Oboro: I can reforge legendary weapons to unlock their ultimate power.', xi.msg.channel.NS_SAY)
    player:printToPlayer('Oboro: Trade me your lv90 weapon with the required materials:', xi.msg.channel.NS_SAY)
    player:printToPlayer('  - Relic weapons:   lv90 weapon + 300 Plutons', xi.msg.channel.NS_SAY)
    player:printToPlayer('  - Mythic weapons:  lv90 weapon + 300 Beitetsu', xi.msg.channel.NS_SAY)
    player:printToPlayer('  - Empyrean weapons: lv90 weapon + 300 Riftborn Boulders', xi.msg.channel.NS_SAY)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
