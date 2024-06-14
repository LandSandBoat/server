-----------------------------------
-- Chocobo Racing
-- https://www.bg-wiki.com/ffxi/Category:Chocobo_Racing
-- https://ffxiclopedia.fandom.com/wiki/Chocobo_Racing_Guide
-----------------------------------
require('scripts/globals/packet')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

-- FOR HEAVILY-IN-DEVELOPMET TESTING, you can force these setting:
-- TODO: When ready for release, publish these to main settings files.
xi.settings.main.ENABLE_CHOCOBO_RACING = false
xi.settings.main.DEBUG_CHOCOBO_RACING = false

-- Notes:
-- Since there is a timed element, packet elements, and a lot of data to fill in,
-- it makes sense to move pretty much everything apart from the CS handling down
-- into core. While developing, things can stay up here, but as this approaches
-- a stable state everything should be pushed down.

-- To Run:
-- !exec xi.chocoboRacing.startRace()

-- https://github.com/atom0s/XiPackets/blob/main/world/server/0x0069/README.md
-- 0x04: Type: 01 (RacingParams)
local chocoboRacingPacket0 = xi.packet.parseFromCaptureString([[
[2021-05-10 22:05:57] Incoming packet 0x069:
        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
    -----------------------------------------------------  ----------------------
      0 | 69 64 37 04 01 00 08 01 C8 00 00 00 01 00 00 80    0 | id7.............
      1 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    1 | ................
      2 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    2 | ................
      3 | 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    3 | ................
      4 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    4 | ................
      5 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    5 | ................
      6 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    6 | ................
      7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
      8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
      9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
      A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
      B | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    B | ................
      C | 00 00 00 00 00 00 00 00 -- -- -- -- -- -- -- --    C | ........--------
]])

-- 0x04: Type: 02 (ChocoboParams)
local chocoboRacingPacket1 = xi.packet.parseFromCaptureString([[
[2021-05-10 22:05:57] Incoming packet 0x069:
        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
    -----------------------------------------------------  ----------------------
      0 | 69 64 37 04 02 00 60 00 12 00 00 00 FF FF 80 00    0 | id7...`.........
      1 | 00 0A 00 13 51 00 00 00 80 60 E0 C0 00 00 34 24    1 | ....Q....`....4$
      2 | 21 00 00 00 C0 80 C0 80 00 06 06 23 41 00 00 00    2 | !..........#A...
      3 | E0 C0 60 80 00 06 08 11 62 00 00 00 C0 00 C0 FF    3 | ..`.....b.......
      4 | 00 A2 26 14 12 00 00 00 FF FF 80 00 00 00 10 11    4 | ..&.............
      5 | 51 00 00 00 80 60 E0 C0 00 00 04 20 12 00 00 00    5 | Q....`..... ....
      6 | FF FF 80 00 00 00 26 13 00 00 00 00 00 00 00 00    6 | ......&.........
      7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
      8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
      9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
      A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
      B | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    B | ................
      C | 00 00 00 00 00 00 00 00 -- -- -- -- -- -- -- --    C | ........--------
]])

-- 0x04: Type: 03 (SectionParams 1)
local chocoboRacingPacket2 = xi.packet.parseFromCaptureString([[
[2021-05-10 22:05:57] Incoming packet 0x069:
        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
    -----------------------------------------------------  ----------------------
      0 | 69 64 37 04 03 00 C0 01 88 88 88 88 77 97 77 67    0 | id7.........w.wg
      1 | 00 08 00 20 77 97 77 67 87 97 67 78 00 00 00 00    1 | ... w.wg..gx....
      2 | 87 97 67 78 87 97 67 78 00 00 00 00 87 97 67 78    2 | ..gx..gx......gx
      3 | 98 97 68 89 40 20 00 05 98 97 68 89 54 B4 A4 3C    3 | ..h.@ ....h.T..<
      4 | 00 68 97 21 54 B4 A4 3C 64 A4 A4 3C 00 00 00 00    4 | .h.!T..<d..<....
      5 | 64 A4 A4 3C 54 93 94 5B 08 80 00 04 54 93 94 5B    5 | d..<T..[....T..[
      6 | 64 93 84 5B 02 00 04 05 64 93 84 5B 75 94 95 6B    6 | d..[....d..[u..k
      7 | 00 00 00 00 75 94 95 6B 75 94 95 6B 00 00 00 00    7 | ....u..ku..k....
      8 | 75 94 95 6B 74 95 95 6B 00 00 00 00 74 95 95 6B    8 | u..kt..k....t..k
      9 | 74 95 85 6B 00 00 00 00 74 95 85 6B 74 85 85 6B    9 | t..k....t..kt..k
      A | 04 04 00 02 74 85 85 6B 74 85 85 6B 00 00 00 00    A | ....t..kt..k....
      B | 74 85 85 6B 84 85 85 6B 00 00 00 00 84 85 85 6B    B | t..k...k.......k
      C | 84 85 85 6B 00 00 00 00 -- -- -- -- -- -- -- --    C | ...k....--------
]])

-- 0x04: Type: 03 (SectionParams 2)
local chocoboRacingPacket3 = xi.packet.parseFromCaptureString([[
[2021-05-10 22:05:58] Incoming packet 0x069:
        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
    -----------------------------------------------------  ----------------------
      0 | 69 64 38 04 03 10 C0 01 84 85 85 6B 84 85 86 6B    0 | id8........k...k
      1 | 00 00 00 00 84 85 86 6B 84 85 86 6B 00 00 00 00    1 | .......k...k....
      2 | 84 85 86 6B 84 85 86 6B 00 00 00 00 84 85 86 6B    2 | ...k...k.......k
      3 | 94 85 86 6B 00 00 00 00 94 85 86 6B 83 74 75 5B    3 | ...k.......k.tu[
      4 | 00 00 00 00 83 74 75 5B 83 74 75 5B 00 00 00 00    4 | .....tu[.tu[....
      5 | 83 74 75 5B 93 85 87 5C 01 01 00 01 93 85 87 5C    5 | .tu[...\\.......\\
      6 | 92 85 87 5C 00 00 00 00 92 85 87 5C A2 96 97 6C    6 | ...\\.......\\...l
      7 | 10 AC 43 06 A2 96 97 6C A2 96 97 6C 00 00 00 00    7 | ..C....l...l....
      8 | A2 96 97 6C A2 96 87 6C 20 20 00 01 A2 96 87 6C    8 | ...l...l  .....l
      9 | A2 96 77 5C 80 80 00 01 A2 96 77 5C A2 96 77 4C    9 | ..w\\......w\\..wL
      A | 7A 00 00 00 A2 96 77 4C A2 96 77 4C FA 00 00 00    A | z.....wL..wL....
      B | A2 96 77 4C A2 96 77 4C 00 00 00 00 A2 96 77 4C    B | ..wL..wL......wL
      C | B2 96 77 4C 00 00 00 00 -- -- -- -- -- -- -- --    C | ..wL....--------
]])

-- 0x04: Type: 04 (ResultParams)
local chocoboRacingPacket4 = xi.packet.parseFromCaptureString([[
[2021-05-10 22:05:58] Incoming packet 0x069:
        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
    -----------------------------------------------------  ----------------------
      0 | 69 64 38 04 04 00 04 00 60 52 34 17 00 00 00 00    0 | id8.....`R4.....
      1 | B8 0B 00 00 B8 04 62 00 00 00 00 00 00 00 00 00    1 | ......b.........
      2 | 0D 63 01 31 00 00 00 00 00 00 00 00 00 00 00 00    2 | .c.1............
      3 | 01 00 07 08 00 10 67 20 67 30 67 40 67 50 00 60    3 | ......g g0g@gP.`
      4 | 00 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00    4 | .p..............
      5 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    5 | ................
      6 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    6 | ................
      7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
      8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
      9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
      A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
      B | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    B | ................
      C | 00 00 00 00 00 00 00 00 -- -- -- -- -- -- -- --    C | ........--------
]])

-- 0x04: Type: 05 (Ready)
local chocoboRacingPacket5 = xi.packet.parseFromCaptureString([[
[2021-05-10 22:05:58] Incoming packet 0x069:
        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
    -----------------------------------------------------  ----------------------
      0 | 69 64 38 04 05 00 00 FF FF FF FF FF FF FF FF FF    0 | id8.............
      1 | FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF    1 | ................
      2 | FF FF FF FF 35 57 08 00 08 0D 62 02 3E 00 64 20    2 | ....5W....b.>.d
      3 | 00 FB 93 38 00 00 20 00 00 00 00 00 20 A0 03 00    3 | ...8.. ..... ...
      4 | D1 15 69 24 00 00 00 00 00 00 00 00 00 00 00 00    4 | ..i$............
      5 | 00 00 00 00 00 00 00 00 00 04 00 00 03 00 00 00    5 | ................
      6 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    6 | ................
      7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
      8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
      9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
      A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
      B | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    B | ................
      C | 00 00 00 00 00 00 00 00 -- -- -- -- -- -- -- --    C | ........--------
]])

local debug = function(player, ...)
    if xi.settings.main.DEBUG_CHOCOBO_RACING then
        local t = { ... }
        print(unpack(t))
        player:printToPlayer(table.concat(t, ' '), xi.msg.channel.SYSTEM_3, '')
    end
end

local setTimer = nil
setTimer = function(player, npcId)
    player:timer(400, function(playerArg)
        playerArg:sendEmptyEntityUpdateToPlayer(GetNPCByID(npcId))
        setTimer(playerArg, npcId)
    end)
end

local startRaceImpl = function(player)
    debug(player, 'Starting race')

    player:sendDebugPacket(chocoboRacingPacket0)
    player:sendDebugPacket(chocoboRacingPacket1)
    player:sendDebugPacket(chocoboRacingPacket2)
    player:sendDebugPacket(chocoboRacingPacket3)
    player:sendDebugPacket(chocoboRacingPacket4)
    player:sendDebugPacket(chocoboRacingPacket5)

    player:startEvent(210, 3885177, 3885177, -132554, -14500, 1344, -1, 610862737, 1)

     -- 'Rungaga' seems to an anchor NPC that everything is orchestrated through?
    setTimer(player, zones[xi.zone.CHOCOBO_CIRCUIT].npc.RUNGAGA)
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
            player:updateEvent(1, 0, -132554, -14500, 389304928, -1, 610862737, -5)
        elseif option == 274 then
            debug(player, 'Names 1-4')
            player:updateEventString(chocobos[1], chocobos[2], chocobos[3], chocobos[4])
            player:updateEvent(70, 0, 7, 4, 389304928, -1, 610862737, -5)
        elseif option == 510 or option == 530 then
            debug(player, 'Names 5-8 and Start')
            player:updateEventString(chocobos[5], chocobos[6], chocobos[7], chocobos[8])
            player:updateEvent(70, 0, 7, 4, 389304928, -1, 610862737, -5)
        elseif option == 17 then
            debug(player, 'End and announce winnings')
            player:updateEvent(70, 0, winningsPerQuill, 1, 0, 3, 3, -5)
        end
    end
end

xi.chocoboRacing.onEventFinish = function(player, csid, option, npc)
    debug(player, 'finish', csid, option)
    if csid == 210 and option == 17 then
        debug(player, 'Hand out winnings')
    end
end
