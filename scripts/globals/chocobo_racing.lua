-----------------------------------
-- Chocobo Racing
-- https://www.bg-wiki.com/ffxi/Category:Chocobo_Racing
-- https://ffxiclopedia.fandom.com/wiki/Chocobo_Racing_Guide
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

-- FOR HEAVILY-IN-DEVELOPMET TESTING, you can force these setting:
-- TODO: When ready for release, publish these to main settings files.
xi.settings.main.ENABLE_CHOCOBO_RACING = false
xi.settings.main.DEBUG_CHOCOBO_RACING = false

-- To Run:
-- !exec xi.chocoboRacing.startRace()

local debug = function(player, ...)
    if xi.settings.main.DEBUG_CHOCOBO_RACING then
        local t = { ... }
        print(unpack(t))
        player:printToPlayer(table.concat(t, ' '), xi.msg.channel.SYSTEM_3, '')
    end
end

local startRaceImpl = function(player)
    debug(player, 'Starting race')
    player:startEvent(210, 3885177, 3885177, -132554, -14500, 1344, -1, 610862737, 1)
end

xi.chocoboRacing.startRace = function()
    local players = GetZone(xi.zone.CHOCOBO_CIRCUIT):getPlayers()
    for _, player in ipairs(players) do
        startRaceImpl(player)
    end
end

-- 0x05C
xi.chocoboRacing.onEventUpdate = function(player, csid, option, npc)
    debug(player, 'update', csid, option)

    local chocobos =
    {
        'Friend',
        'Neddy',
        'Beau',
        'Grand',
        'Reppu',
        'Ace',
        'Winning',
        'Northern',
    }

    local winningsPerQuill = 1076

    if csid == 210 then
        if option == 5 then
            debug(player, 'Intro banner')
            player:updateEvent(1, 0, 0xFFFDFA36, 0xFFFFC75C, 0x17345260, 0xFFFFFFFF, 0x24690691, 0xFFFFFFFB)
        elseif option == 274 then
            debug(player, 'Names 1-4')
            player:updateEventString(chocobos[1], chocobos[2], chocobos[3], chocobos[4],
                0x000060B9, 0x000000B9)
            player:updateEvent(70, 0, 7, 4, 0x17345260, 0xFFFFFFFF, 0x24690691, 0xFFFFFFFB)
        elseif option == 510 or option == 530 then
            debug(player, 'Names 5-8 and Start')
            player:updateEventString(chocobos[5], chocobos[6], chocobos[7], chocobos[8],
                0x00002928, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x00085735)
            player:updateEvent(70, 0, 7, 4, 0x17345260, 0xFFFFFFFF, 0x24690691, 0xFFFFFFFB)
        elseif option == 17 then
            debug(player, 'End and announce winnings')
            player:updateEvent(70, 0, winningsPerQuill, 1, 0, 3, 3, 0xFFFFFFFB)
        end
    end
end

xi.chocoboRacing.onEventFinish = function(player, csid, option, npc)
    debug(player, 'finish', csid, option)
    if csid == 210 and option == 17 then
        debug(player, 'Hand out winnings')
    end
end
