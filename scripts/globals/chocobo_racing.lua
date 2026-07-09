-----------------------------------
-- Chocobo Racing
-- https://www.bg-wiki.com/ffxi/Category:Chocobo_Racing
-- https://ffxiclopedia.fandom.com/wiki/Chocobo_Racing_Guide
-----------------------------------
require('scripts/globals/packet')
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

local settings                         =
{
    RACE_PERIOD    = 900,        -- A race every 15 minutes.
    VANADIEL_EPOCH = 1009810800, -- Jan 1 2002
}

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
-- From your capture, paste in the contents of: packetviewer/incoming/0x069.log
local combinedPacketData = [[
[2024-06-08 16:51:00]
        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
    -----------------------------------------------------  ----------------------
      0 | 69 64 6C 1B 01 00 08 01 C8 00 00 00 00 00 00 80    0 | idl.............
      1 | CF F7 8F C0 85 6B C2 C2 00 00 00 00 32 32 64 00    1 | .....k......22d.
      2 | 06 1B 00 00 00 00 00 20 00 00 00 00 00 00 00 00    2 | ....... ........
      3 | 01 00 05 02 17 10 17 20 17 30 17 40 17 50 00 60    3 | ....... .0.@.P.`
      4 | 00 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00    4 | .p..............
      5 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    5 | ................
      6 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    6 | ................
      7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
      8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
      9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
      A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
      B | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    B | ................
      C | 00 00 00 00 00 00 00 00 -- -- -- -- -- -- -- --    C | ........--------

[2024-06-08 16:51:01]
        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
    -----------------------------------------------------  ----------------------
      0 | 69 64 6D 1B 02 00 60 00 41 00 00 00 00 00 00 00    0 | idm...`.A.....`.
      1 | 00 00 08 15 41 00 00 00 00 00 00 00 00 00 00 00    1 | ....A.....`....!
      2 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    2 | b.........V.!...
      3 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    3 | ......$.b.......
      4 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    4 | ..""A.....`...".
      5 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    5 | b.....@@.. .0...
      6 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    6 | ......"#........
      7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
      8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
      9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
      A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
      B | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    B | ................
      C | 00 00 00 00 00 00 00 00 -- -- -- -- -- -- -- --    C | ........--------

[2024-06-08 16:51:01]
        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
    -----------------------------------------------------  ----------------------
      0 | 69 64 6D 1B 03 00 C0 00 88 88 88 88 89 66 98 85    0 | idm..........f..
      1 | 00 B3 00 20 89 66 98 85 89 77 99 86 00 00 00 00    1 | ... .f...w......
      2 | 89 77 99 86 89 77 99 86 00 00 00 00 89 77 99 86    2 | .w...w.......w..
      3 | 88 77 99 86 80 80 00 03 88 77 99 86 88 77 99 86    3 | .w.......w...w..
      4 | 00 00 00 00 88 77 99 86 78 67 88 88 02 40 00 04    4 | .....w..xg...@..
      5 | 78 67 88 88 77 67 88 78 00 00 00 00 77 67 88 78    5 | xg..wg.x....wg.x
      6 | 77 67 88 87 08 08 00 02 77 67 88 87 77 67 78 87    6 | wg......wg..wgx.
      7 | 01 00 08 04 77 67 78 87 77 67 78 87 00 00 00 00    7 | ....wgx.wgx.....
      8 | 77 67 78 87 77 67 78 87 00 00 00 00 77 67 78 87    8 | wgx.wgx.....wgx.
      9 | 77 68 78 87 00 00 00 00 77 68 78 87 77 68 79 87    9 | whx.....whx.why.
      A | 00 00 00 00 77 68 79 87 66 57 79 76 04 30 CB 06    A | ....why.fWyv.0..
      B | 66 57 79 76 66 57 79 86 20 00 08 04 66 57 79 86    B | fWyvfWy. ...fWy.
      C | 66 67 79 85 00 00 00 00 -- -- -- -- -- -- -- --    C | fgy.....--------

[2024-06-08 16:51:01]
        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
    -----------------------------------------------------  ----------------------
      0 | 69 64 6D 1B 03 10 C0 00 66 67 79 85 67 57 79 86    0 | idm.....fgy.gWy.
      1 | 00 00 00 00 67 57 79 86 67 57 79 86 00 00 00 00    1 | ....gWy.gWy.....
      2 | 67 57 79 86 67 57 79 86 00 00 00 00 67 57 79 86    2 | gWy.gWy.....gWy.
      3 | 67 67 79 95 00 00 00 00 67 67 79 95 67 68 79 95    3 | ggy.....ggy.ghy.
      4 | 00 00 00 00 67 68 79 95 67 58 79 96 00 00 00 00    4 | ....ghy.gXy.....
      5 | 67 58 79 96 67 68 79 95 10 0C E3 06 67 68 79 95    5 | gXy.ghy.....ghy.
      6 | 68 79 7A A5 40 99 26 06 68 79 7A A5 89 6A 69 A4    6 | hyz.@.&.hyz..ji.
      7 | 00 07 F8 21 89 6A 69 A4 89 6A 69 A4 95 00 00 00    7 | ...!.ji..ji.....
      8 | 89 6A 69 A4 89 6A 69 A4 95 00 00 00 89 6A 69 A4    8 | .ji..ji......ji.
      9 | 89 6A 69 A4 D7 00 00 00 89 6A 69 A4 89 6A 69 B4    9 | .ji......ji..ji.
      A | F7 00 00 00 89 6A 69 B4 89 69 69 B4 F7 00 00 00    A | .....ji..ii.....
      B | 89 69 69 B4 79 69 69 B4 00 00 00 00 79 69 69 B4    B | .ii.yii.....yii.
      C | 79 59 69 B4 00 00 00 00 -- -- -- -- -- -- -- --    C | yYi.....--------

[2024-06-08 16:51:01]
        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
    -----------------------------------------------------  ----------------------
      0 | 69 64 6D 1B 04 00 04 00 34 16 25 70 0A 00 00 00    0 | idm.....4.%p....
      1 | 30 EE 00 00 20 73 64 15 00 00 00 00 00 00 00 00    1 | 0... sd.........
      2 | FB FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00    2 | ................
      3 | 00 00 34 00 63 61 6D 65 72 61 42 00 00 00 00 00    3 | ..4.cameraB.....
      4 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    4 | ................
      5 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    5 | ................
      6 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    6 | ................
      7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
      8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
      9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
      A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
      B | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    B | ................
      C | 00 00 00 00 00 00 00 00 -- -- -- -- -- -- -- --    C | ........--------

[2024-06-08 16:51:01]
        |  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F      | 0123456789ABCDEF
    -----------------------------------------------------  ----------------------
      0 | 69 64 6E 1B 05 00 00 00 27 00 57 00 00 00 00 00    0 | idn.....'.W.....
      1 | 00 00 00 00 00 00 00 00 00 00 00 00 32 32 64 00    1 | ............22d.
      2 | 02 19 00 00 00 00 00 20 00 00 00 00 00 00 00 00    2 | ....... ........
      3 | 07 00 20 00 00 00 01 00 00 00 00 00 00 00 00 00    3 | .. .............
      4 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    4 | ................
      5 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    5 | ................
      6 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    6 | ................
      7 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    7 | ................
      8 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    8 | ................
      9 | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    9 | ................
      A | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    A | ................
      B | 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    B | ................
      C | 00 00 00 00 00 00 00 00 -- -- -- -- -- -- -- --    C | ........--------
]]

local debug = function(player, ...)
    if xi.settings.main.DEBUG_CHOCOBO_RACING then
        local t = { ... }
        print(unpack(t))
        player:printToPlayer(table.concat(t, ' '), xi.msg.channel.SYSTEM_3, '')
    end
end

local setTimer = function(player, npcId)
end

setTimer = function(player, npcId)
    player:timer(400, function(playerArg)
        playerArg:sendEmptyEntityUpdateToPlayer(GetNPCByID(npcId))
        setTimer(playerArg, npcId)
    end)
end

local startRaceImpl = function(player)
    debug(player, 'Starting race')

    for _, packet in ipairs(xi.packet.parseMultiplePackets(combinedPacketData)) do
        if packet[0x04 + 1] == 0x02 then
            -- Races:
            -- 0x0: Galka
            -- 0x1: Hume M
            -- 0x2: Hume F
            -- 0x3: Elvaan M
            -- 0x4: Elvaan F
            -- 0x5: Tarutaru M
            -- 0x6: Tarutaru F
            -- 0x7: Mithra
            local races = { 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7 }

            -- Colors:
            -- 0x0: Yellow
            -- 0x1: Yellow
            -- 0x2: Black
            -- 0x3: Black
            -- 0x4: Blue
            -- 0x5: Blue
            -- 0x6: Red
            -- 0x7: Red
            -- 0x8: Green
            local colors = { 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8 }

            for _, offset in ipairs({ 0x0C, 0x18, 0x24, 0x30, 0x3C, 0x48, 0x54, 0x60 }) do
                local race   = utils.randomEntry(races)
                local color = utils.randomEntry(colors)

                -- Remember Lua is 1-offset!
                packet[offset + 0 + 1] = 0x0E
                packet[offset + 1 + 1] = 0x0C
                packet[offset + 2 + 1] = 0x60
                packet[offset + 3 + 1] = 0x80
                packet[offset + 4 + 1] = 0x00
                packet[offset + 5 + 1] = 0x00
                packet[offset + 6 + 1] = 0x08
                packet[offset + 7 + 1] = bit.lshift(race, 4) + color
                packet[offset + 8 + 1] = 0x41
                packet[offset + 9 + 1] = 0x00
                packet[offset + 10 + 1] = 0x00
                packet[offset + 11 + 1] = 0x00
            end
        end

        player:sendDebugPacket(packet)
    end

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
        'One',
        'Two',
        'Three',
        'Four',
        'Five',
        'Six',
        'Seven',
        'Eight',
    }

    local winningsPerQuill = 1076

    local unknown0 = 389304928
    local unknown1 = -1
    local unknown2 = 610862737
    local unknown3 = -5

    -- NOTE: The race win order seems to be encoded in here

    if csid == 210 then
        if option == 5 then
            debug(player, 'Intro banner')
            player:updateEvent(1, 0, -132554, -14500, unknown0, unknown1, unknown2, unknown3)
        elseif option == 274 then
            debug(player, 'Names 1-4')
            player:updateEventString(chocobos[1], chocobos[2], chocobos[3], chocobos[4])
            player:updateEvent(70, 0, 7, 4, unknown0, unknown1, unknown2, unknown3)
        elseif option == 510 or option == 530 then
            debug(player, 'Names 5-8 and Start')
            player:updateEventString(chocobos[5], chocobos[6], chocobos[7], chocobos[8])
            player:updateEvent(70, 0, 7, 4, unknown0, unknown1, unknown2, unknown3)
        elseif option == 17 then
            debug(player, 'End and announce winnings')
            player:updateEvent(70, 0, winningsPerQuill, 1, 0, 3, 3, unknown3)
        end
    end
end

xi.chocoboRacing.onEventFinish = function(player, csid, option, npc)
    debug(player, 'finish', csid, option)
    if csid == 210 and option == 17 then
        debug(player, 'Hand out winnings')
    end
end

-- This is an example set of 8 Chocobos competing in the upcoming race
-- Replace with actual chocobos when implementing.
local fakeChocoboRacers                =
{
    {
        name        = 'Joyeuse',
        orders      = xi.chocoboRacing.order.KEEP_PACE,
        item        = xi.chocoboRacing.sectionEvent.SPEED_APPLE,
        weather     = xi.chocoboRaising.weather.RAINY,
        color       = xi.chocoboRaising.color.BLACK,
        gender      = xi.chocoboRaising.gender.FEMALE,
        size        = xi.chocoboRacing.jockeySize.HUME_M,
        ability1    = xi.chocoboRaising.ability.BURROW,
        ability2    = xi.chocoboRaising.ability.NONE,
        temperament = xi.chocoboRaising.temperament.VERY_PATIENT,
        stats       =
        {
            str     = xi.chocoboRaising.statRank.BETTER_THAN_AVG,
            ['end'] = xi.chocoboRaising.statRank.OUTSTANDING,
            dsc     = xi.chocoboRaising.statRank.IMPRESSIVE,
            rcp     = xi.chocoboRaising.statRank.IMPRESSIVE,
        },
    },
    {
        name        = 'Schuss',
        orders      = xi.chocoboRacing.order.KEEP_PACE,
        item        = xi.chocoboRacing.sectionEvent.FIRE_BISCUIT,
        weather     = xi.chocoboRaising.weather.CLEAR,
        color       = xi.chocoboRaising.color.RED,
        gender      = xi.chocoboRaising.gender.MALE,
        size        = xi.chocoboRacing.jockeySize.HUME_M,
        ability1    = xi.chocoboRaising.ability.NONE,
        ability2    = xi.chocoboRaising.ability.NONE,
        temperament = xi.chocoboRaising.temperament.ILL_TEMPERED,
        stats       =
        {
            str     = xi.chocoboRaising.statRank.BETTER_THAN_AVG,
            ['end'] = xi.chocoboRaising.statRank.AVERAGE,
            dsc     = xi.chocoboRaising.statRank.FIRST_CLASS,
            rcp     = xi.chocoboRaising.statRank.OUTSTANDING,
        },
    },
    {
        name        = 'Humble',
        orders      = xi.chocoboRacing.order.FINAL_SPURT,
        item        = xi.chocoboRacing.sectionEvent.SPEED_APPLE,
        weather     = xi.chocoboRaising.weather.CLEAR,
        color       = xi.chocoboRaising.color.BLACK,
        gender      = xi.chocoboRaising.gender.MALE,
        size        = xi.chocoboRacing.jockeySize.HUME_F,
        ability1    = xi.chocoboRaising.ability.BURROW,
        ability2    = xi.chocoboRaising.ability.GALLOP,
        temperament = xi.chocoboRaising.temperament.QUITE_SENSITIVE,
        stats       =
        {
            str     = xi.chocoboRaising.statRank.FIRST_CLASS,
            ['end'] = xi.chocoboRaising.statRank.FIRST_CLASS,
            dsc     = xi.chocoboRaising.statRank.BETTER_THAN_AVG,
            rcp     = xi.chocoboRaising.statRank.POOR,
        },
    },
    {
        name        = 'Melody',
        orders      = xi.chocoboRacing.order.FINAL_SPURT,
        item        = xi.chocoboRacing.sectionEvent.GYSAHL_BOMB,
        weather     = xi.chocoboRaising.weather.CLEAR,
        color       = xi.chocoboRaising.color.GREEN,
        gender      = xi.chocoboRaising.gender.MALE,
        size        = xi.chocoboRacing.jockeySize.HUME_M,
        ability1    = xi.chocoboRaising.ability.NONE,
        ability2    = xi.chocoboRaising.ability.NONE,
        temperament = xi.chocoboRaising.temperament.VERY_PATIENT,
        stats       =
        {
            str     = xi.chocoboRaising.statRank.FIRST_CLASS,
            ['end'] = xi.chocoboRaising.statRank.FIRST_CLASS,
            dsc     = xi.chocoboRaising.statRank.A_BIT_DEFICIENT,
            rcp     = xi.chocoboRaising.statRank.A_BIT_DEFICIENT,
        },
    },
    {
        name        = 'Gagnante',
        orders      = xi.chocoboRacing.order.KEEP_PACE,
        item        = xi.chocoboRacing.sectionEvent.PEPPER_BISCUIT,
        weather     = xi.chocoboRaising.weather.RAINY,
        color       = xi.chocoboRaising.color.RED,
        gender      = xi.chocoboRaising.gender.MALE,
        size        = xi.chocoboRacing.jockeySize.HUME_F,
        ability1    = xi.chocoboRaising.ability.BURROW,
        ability2    = xi.chocoboRaising.ability.CANTER,
        temperament = xi.chocoboRaising.temperament.ENIGMATIC,
        stats       =
        {
            str     = xi.chocoboRaising.statRank.FIRST_CLASS,
            ['end'] = xi.chocoboRaising.statRank.OUTSTANDING,
            dsc     = xi.chocoboRaising.statRank.AVERAGE,
            rcp     = xi.chocoboRaising.statRank.BETTER_THAN_AVG,
        },
    },
    {
        name        = 'Jolie',
        orders      = xi.chocoboRacing.order.KEEP_PACE,
        item        = xi.chocoboRacing.sectionEvent.FIRE_BISCUIT,
        weather     = xi.chocoboRaising.weather.SANDSTORMS,
        color       = xi.chocoboRaising.color.YELLOW,
        gender      = xi.chocoboRaising.gender.FEMALE,
        size        = xi.chocoboRacing.jockeySize.HUME_F,
        ability1    = xi.chocoboRaising.ability.BORE,
        ability2    = xi.chocoboRaising.ability.NONE,
        temperament = xi.chocoboRaising.temperament.ENIGMATIC,
        stats       =
        {
            str     = xi.chocoboRaising.statRank.BETTER_THAN_AVG,
            ['end'] = xi.chocoboRaising.statRank.AVERAGE,
            dsc     = xi.chocoboRaising.statRank.FIRST_CLASS,
            rcp     = xi.chocoboRaising.statRank.OUTSTANDING,
        },
    },
    {
        name        = 'Invincible',
        orders      = xi.chocoboRacing.order.SPRINT,
        item        = xi.chocoboRacing.sectionEvent.SHADOW_APPLE,
        weather     = xi.chocoboRaising.weather.CLEAR,
        color       = xi.chocoboRaising.color.YELLOW,
        gender      = xi.chocoboRaising.gender.FEMALE,
        size        = xi.chocoboRacing.jockeySize.HUME_M,
        ability1    = xi.chocoboRaising.ability.NONE,
        ability2    = xi.chocoboRaising.ability.NONE,
        temperament = xi.chocoboRaising.temperament.ILL_TEMPERED,
        stats       =
        {
            str     = xi.chocoboRaising.statRank.FIRST_CLASS,
            ['end'] = xi.chocoboRaising.statRank.FIRST_CLASS,
            dsc     = xi.chocoboRaising.statRank.POOR,
            rcp     = xi.chocoboRaising.statRank.POOR,
        },
    },
    {
        name        = 'Bec',
        orders      = xi.chocoboRacing.order.KEEP_PACE,
        item        = xi.chocoboRacing.sectionEvent.FIRE_BISCUIT,
        weather     = xi.chocoboRaising.weather.CLEAR,
        color       = xi.chocoboRaising.color.YELLOW,
        gender      = xi.chocoboRaising.gender.FEMALE,
        size        = xi.chocoboRacing.jockeySize.HUME_F,
        ability1    = xi.chocoboRaising.ability.NONE,
        ability2    = xi.chocoboRaising.ability.NONE,
        temperament = xi.chocoboRaising.temperament.QUITE_SENSITIVE,
        stats       =
        {
            str     = xi.chocoboRaising.statRank.BETTER_THAN_AVG,
            ['end'] = xi.chocoboRaising.statRank.AVERAGE,
            dsc     = xi.chocoboRaising.statRank.FIRST_CLASS,
            rcp     = xi.chocoboRaising.statRank.OUTSTANDING,
        },
    },
}

-- Return auto-generated race number, advancing every 15 minutes
xi.chocoboRacing.currentRaceNo         = function()
    return math.floor(GetSystemTime() / settings.RACE_PERIOD)
end

-- Sends the "Betting ends in..." countdown via a PENDINGNUM
xi.chocoboRacing.sendBettingCountdown   = function(player, listIndex)
    local now      = GetSystemTime()
    local closesIn = settings.RACE_PERIOD - (now % settings.RACE_PERIOD)
    player:updateEvent(
        closesIn,                      -- When the betting period ends
        now - settings.VANADIEL_EPOCH, -- Current server time. Used by client to know when to refresh.
        0, 0, 0,
        closesIn,                      -- When the betting period ends
        1,                             -- Unknown
        listIndex or 0                 -- Presently unused but may be used to index into a different race
    )
end

xi.chocoboRacing.onToteboardTrigger     = function(player, eventId)
    player:startEvent(
        eventId,                                   -- NPC Event ID
        1,                                         -- Race weather
        -1, -1, -1,                                -- PC position, retail sends -1
        player:getRotPos() * 16,                   -- PC rotation, retail sends rot * 16
        0,                                         -- Copied but never used by event scripts
        GetSystemTime() - settings.VANADIEL_EPOCH, -- Server timestamp, appears to be unused by event
        2                                          -- 2 opens the board, -1 shows "Preparations for the next race are underway"
    )
end

xi.chocoboRacing.onToteboardEventUpdate = function(player, option)
    -- Client is browsing to the Toteboard or the client is requesting an automatic update
    if option == 3 or option == 4 then
        xi.chocoboRacing.sendBettingCountdown(player, 0)
        return
    end

    -- Client is requesting to view a specific chocobo from the Paddock
    if option % 8 == 0 and option <= 56 then
        local slot  = math.floor(option / 8)
        local choco = fakeChocoboRacers[slot + 1]
        if choco then
            -- Pack the chocobo stats for event purposes:
            -- statBytes = STR|END|DSC|RCP, dna = the ability/weather/gender/colour/size/temperament bitfield.
            local stats     = choco.stats
            local statBytes = bit.bor(bit.lshift(stats.str, 5), bit.lshift(stats['end'], 13), bit.lshift(stats.dsc, 21), bit.lshift(stats.rcp, 29))
            local dna       = bit.bor(bit.lshift(choco.ability1, 9), bit.lshift(choco.ability2, 13), bit.lshift(choco.temperament, 17), bit.lshift(choco.weather, 20), bit.lshift(choco.gender, 24),
                bit.lshift(choco.color, 25), bit.lshift(choco.size, 28))

            -- First, send a PENDINGSTR with the name of the Chocobo (all 4 slots)
            player:updateEventString(choco.name, choco.name, choco.name, choco.name)
            -- Second, update the event VM with the Chocobo stats
            player:updateEvent(6, 0, choco.orders, choco.item, statBytes, dna, 1, slot * 2)
        end
    end
end

-- Flow race information back to core for specific menu requests. (Toteboard)
xi.chocoboRacing.onRaceRequest          = function(player, param, kind)
    if kind == 1 then -- Toteboard: betting odds
        -- Quinella odds: exactly 28 entries must be passed, one per chocobo pair (8-choose-2 = 28),
        -- in this fixed order (a pair = the two chocobos finishing 1st/2nd, in either order):
        --   [1]=(1,2)  [2]=(1,3)  [3]=(1,4)  [4]=(1,5)  [5]=(1,6)  [6]=(1,7)  [7]=(1,8)
        --   [8]=(2,3)  [9]=(2,4)  [10]=(2,5) [11]=(2,6) [12]=(2,7) [13]=(2,8)
        --   [14]=(3,4) [15]=(3,5) [16]=(3,6) [17]=(3,7) [18]=(3,8)
        --   [19]=(4,5) [20]=(4,6) [21]=(4,7) [22]=(4,8)
        --   [23]=(5,6) [24]=(5,7) [25]=(5,8)
        --   [26]=(6,7) [27]=(6,8)
        --   [28]=(7,8)
        -- Each value is that pair's payout; 50000 means "no bet".
        return
        {
            grade      = xi.chocoboRacing.raceGrade.C4,
            raceNumber = xi.chocoboRacing.currentRaceNo(),
            odds       = { 10050, 773, 837, 913, 50000, 50000, 773, 2512, 3350, 2512, 50000, 50000, 50000, 558, 670, 50000, 50000, 1256, 628, 50000, 50000, 773, 50000, 50000, 3350, 50000, 50000, 50000 },
        }
    end

    -- ChocoboList: race weather and entrant field
    return
    {
        weather  = xi.weather.SUNSHINE,
        chocobos = fakeChocoboRacers,
    }
end
