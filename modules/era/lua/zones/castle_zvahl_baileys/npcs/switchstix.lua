-----------------------------------
-- Relic Weapon Waits Era Module
-- Restores the waits Switchstix takes to finish each stage of a relic weapon to previous era waits.
-- The June 7, 2016 version update shortened all three wait timers.
-----------------------------------
-- Source: https://forum.square-enix.com/ffxi/threads/50760-Jun.-7-2016-(JST)-Version-Update
-- Source: https://wiki.ffo.jp/html/21312.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_relic_weapon_waits', xi.pre(xi.expansion.ROV))

-- Switchstix finishes a first stage weapon at Japanese midnight.
-- The later stages run on the clock.
local eraWaitTime =
{
    [2] = 604800, -- 7 days (Earth time)
    [3] = 302400, -- 84 hours (Earth time)
}

-- The stage of every weapon Switchstix takes in trade.
-- A fourth stage weapon is finished at a ??? and never waits.
local relicStage =
{
    -- Spharai
    [xi.item.RELIC_KNUCKLES]    = 1,
    [xi.item.MILITANT_KNUCKLES] = 2,
    [xi.item.DYNAMIS_KNUCKLES]  = 3,

    -- Mandau
    [xi.item.RELIC_DAGGER]      = 1,
    [xi.item.MALEFIC_DAGGER]    = 2,
    [xi.item.DYNAMIS_DAGGER]    = 3,

    -- Excalibur
    [xi.item.RELIC_SWORD]       = 1,
    [xi.item.GLYPTIC_SWORD]     = 2,
    [xi.item.DYNAMIS_SWORD]     = 3,

    -- Ragnarok
    [xi.item.RELIC_BLADE]       = 1,
    [xi.item.GILDED_BLADE]      = 2,
    [xi.item.DYNAMIS_BLADE]     = 3,

    -- Guttler
    [xi.item.RELIC_AXE]         = 1,
    [xi.item.LEONINE_AXE]       = 2,
    [xi.item.DYNAMIS_AXE]       = 3,

    -- Bravura
    [xi.item.RELIC_BHUJ]        = 1,
    [xi.item.AGONAL_BHUJ]       = 2,
    [xi.item.DYNAMIS_BHUJ]      = 3,

    -- Gungnir
    [xi.item.RELIC_LANCE]       = 1,
    [xi.item.HOTSPUR_LANCE]     = 2,
    [xi.item.DYNAMIS_LANCE]     = 3,

    -- Apocalypse
    [xi.item.RELIC_SCYTHE]      = 1,
    [xi.item.MEMENTO_SCYTHE]    = 2,
    [xi.item.DYNAMIS_SCYTHE]    = 3,

    -- Kikoku
    [xi.item.IHINTANTO]         = 1,
    [xi.item.MIMIZUKU]          = 2,
    [xi.item.ROGETSU]           = 3,

    -- Amanomurakumo
    [xi.item.ITO]               = 1,
    [xi.item.HAYATEMARU]        = 2,
    [xi.item.OBOROMARU]         = 3,

    -- Mjollnir
    [xi.item.RELIC_MAUL]        = 1,
    [xi.item.BATTERING_MAUL]    = 2,
    [xi.item.DYNAMIS_MAUL]      = 3,

    -- Claustrum
    [xi.item.RELIC_STAFF]       = 1,
    [xi.item.SAGES_STAFF]       = 2,
    [xi.item.DYNAMIS_STAFF]     = 3,

    -- Annihilator
    [xi.item.RELIC_GUN]         = 1,
    [xi.item.MARKSMANS_GUN]     = 2,
    [xi.item.DYNAMIS_GUN]       = 3,

    -- Gjallarhorn
    [xi.item.RELIC_HORN]        = 1,
    [xi.item.PYRRHIC_HORN]      = 2,
    [xi.item.DYNAMIS_HORN]      = 3,

    -- Yoichinoyumi
    [xi.item.RELIC_BOW]         = 1,
    [xi.item.WOLVER_BOW]        = 2,
    [xi.item.DYNAMIS_BOW]       = 3,

    -- Aegis
    [xi.item.RELIC_SHIELD]      = 1,
    [xi.item.BULWARK_SHIELD]    = 2,
    [xi.item.DYNAMIS_SHIELD]    = 3,
}

m:addOverride('xi.zones.Castle_Zvahl_Baileys.npcs.Switchstix.onTrade', function(player, npc, trade)
    local dueAt = player:getCharVar('RELIC_DUE_AT')

    super(player, npc, trade)

    -- Switchstix starts work when the commission is paid.
    -- A player already mid-wait keeps the timer they started with.
    if player:getCharVar('RELIC_DUE_AT') == dueAt then
        return
    end

    local stage = relicStage[player:getCharVar('RELIC_IN_PROGRESS')]
    local waitTime = eraWaitTime[stage]

    if stage == 1 then
        player:setCharVar('RELIC_DUE_AT', JstMidnight())
    elseif waitTime then
        player:setCharVar('RELIC_DUE_AT', GetSystemTime() + waitTime)
    end
end)
