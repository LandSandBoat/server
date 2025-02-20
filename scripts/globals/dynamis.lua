-----------------------------------
-- Dynamis
-----------------------------------
require('scripts/globals/battlefield')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.dynamis = xi.dynamis or {}

local entryInfo =
{
    --[[
    [zone] =
    {
        csBit    = the bit in the Dynamis_Status player variable that records whether player has beaten this dynamis
                   this bit number is also given to the start Dynamis event and message.
        csVial   = event ID for cutscene where Cornelia gives you the vial of shrouded sand
        csBeat   = event ID for cutscene after you have beaten this Dynamis
        csMenu   = event ID for entering Dynamis
        beatVar  = variable used to denote players who have beaten this Dynamis, but not yet viewed the cutscene
        beatKI   = key item given as reward for this Dynamis
        enterPos = coordinates where player will be placed when entering this Dynamis
        reqs     = function that returns true if player meets requirements for entering this Dynamis
                   minimum level and timer are checked separately
    }
    --]]

    [xi.zone.SOUTHERN_SAN_DORIA] =
    {
        csBit    = 1,
        csVial   = 686,
        csFirst  = 692,
        csBeat   = 698,
        csMenu   = 961,
        beatVar  = 'DynaSandoria_Win',
        beatKI   = xi.ki.HYDRA_CORPS_COMMAND_SCEPTER,
        enterPos = { 161.838, -2.000, 161.673, 93, 185 },
    },

    [xi.zone.BASTOK_MINES] =
    {
        csBit    = 2,
        csVial   = 203,
        csFirst  = 209,
        csBeat   = 215,
        csMenu   = 597,
        beatVar  = 'DynaBastok_Win',
        beatKI   = xi.ki.HYDRA_CORPS_EYEGLASS,
        enterPos = { 116.482, 0.994, -72.121, 128, 186 },
    },

    [xi.zone.WINDURST_WALLS] =
    {
        csBit    = 3,
        csVial   = 455,
        csFirst  = 459,
        csBeat   = 465,
        csMenu   = 513,
        beatVar  = 'DynaWindurst_Win',
        beatKI   = xi.ki.HYDRA_CORPS_LANTERN,
        enterPos = { -221.988, 1.000, -120.184, 0, 187 },
    },

    [xi.zone.RULUDE_GARDENS] =
    {
        csBit    = 4,
        csVial   = 10016,
        csFirst  = 10020,
        csBeat   = 10026,
        csMenu   = 10176,
        beatVar  = 'DynaJeuno_Win',
        beatKI   = xi.ki.HYDRA_CORPS_TACTICAL_MAP,
        enterPos = { 48.930, 10.002, -71.032, 195, 188 },
    },

    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        csBit    = 5,
        csFirst  = 128,
        csBeat   = 134,
        csMenu   = 229,
        beatVar  = 'DynaBeaucedine_Win',
        beatKI   = xi.ki.HYDRA_CORPS_INSIGNIA,
        enterPos = { -284.751, -39.923, -422.948, 235, 134 },
        reqs     = function(player)
            return player:hasKeyItem(xi.ki.HYDRA_CORPS_COMMAND_SCEPTER) and
                player:hasKeyItem(xi.ki.HYDRA_CORPS_EYEGLASS) and
                player:hasKeyItem(xi.ki.HYDRA_CORPS_LANTERN) and
                player:hasKeyItem(xi.ki.HYDRA_CORPS_TACTICAL_MAP)
        end,
    },

    [xi.zone.XARCABARD] =
    {
        csBit    = 6,
        csFirst  = 26,
        csBeat   = 32,
        csMenu   = 205,
        beatVar  = 'DynaXarcabard_Win',
        beatKI   = xi.ki.HYDRA_CORPS_BATTLE_STANDARD,
        enterPos = { 569.312, -0.098, -270.158, 90, 135 },
        reqs     = function(player)
            return player:hasKeyItem(xi.ki.HYDRA_CORPS_INSIGNIA)
        end,
    },

    -- TODO: Make absolutely sure that winning Xarcabard does NOT allow early access to dreamlands BEFORE CoP 3-5
    [xi.zone.VALKURM_DUNES] =
    {
        csBit    = 7,
        csFirst  = 33,
        csBeat   = 39,
        csMenu   = 58,
        beatVar  = 'DynaValkurm_Win',
        beatKI   = xi.ki.DYNAMIS_VALKURM_SLIVER,
        enterPos = { 100, -8, 131, 47, 39 },
        reqs = function(player)
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) or
                xi.settings.main.FREE_COP_DYNAMIS == 1
        end,
    },

    [xi.zone.BUBURIMU_PENINSULA] =
    {
        csBit    = 8,
        csFirst  = 40,
        csBeat   = 46,
        csMenu   = 64,
        beatVar  = 'DynaBuburimu_Win',
        beatKI   = xi.ki.DYNAMIS_BUBURIMU_SLIVER,
        enterPos = { 155, -1, -169, 170, 40 },
        reqs = function(player)
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) or
                xi.settings.main.FREE_COP_DYNAMIS == 1
        end,
    },

    [xi.zone.QUFIM_ISLAND] =
    {
        csBit    = 9,
        csFirst  = 22,
        csBeat   = 28,
        csMenu   = 48,
        beatVar  = 'DynaQufim_Win',
        beatKI   = xi.ki.DYNAMIS_QUFIM_SLIVER,
        enterPos = { -19, -17, 104, 253, 41 },
        reqs = function(player)
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) or
                xi.settings.main.FREE_COP_DYNAMIS == 1
        end,
    },

    [xi.zone.TAVNAZIAN_SAFEHOLD] =
    {
        csBit    = 10,
        csFirst  = 614,
        -- TODO: Tavnazian winning CS changes Param2 (part of dialogue) depending on CoP progress ranging from 0 ('she will pay dearly') up to 3 ('you know this girl well')
        --       The exact mission breaking points for each bit need captures or testimonies; Param1 seems to be 0 or garbage
        csBeat   = 615,
        csMenu   = 624,
        beatVar  = 'DynaTavnazia_Win',
        beatKI   = xi.ki.DYNAMIS_TAVNAZIA_SLIVER,
        enterPos = { 0.1, -7, -21, 190, 42 },
        reqs     = function(player)
            return player:hasKeyItem(xi.ki.DYNAMIS_BUBURIMU_SLIVER) and
                player:hasKeyItem(xi.ki.DYNAMIS_QUFIM_SLIVER) and
                player:hasKeyItem(xi.ki.DYNAMIS_VALKURM_SLIVER)
        end,
    },
}

local dynaInfo =
{
    --[[
    [zone] =
    {
        entryPos = default entry coordinates (used for GMs warping to zone, for example)
        ejectPos = coordinates outside, where players will be sent when running out of time or using Somnial Threshold
    }
    --]]

    [xi.zone.DYNAMIS_SAN_DORIA] =
    {
        beatVar   = 'DynaSandoria_Win',
        beatKI    = xi.ki.HYDRA_CORPS_COMMAND_SCEPTER,
        beatTitle = xi.title.DYNAMIS_SAN_DORIA_INTERLOPER,
        entryPos  = { 161.838, -2.000, 161.673, 93 },
        ejectPos  = { 161.000, -2.000, 161.000, 94, 230 },
    },

    [xi.zone.DYNAMIS_BASTOK] =
    {
        beatVar   = 'DynaBastok_Win',
        beatKI    = xi.ki.HYDRA_CORPS_EYEGLASS,
        beatTitle = xi.title.DYNAMIS_BASTOK_INTERLOPER,
        entryPos  = { 116.482, 0.994, -72.121, 128 },
        ejectPos  = { 112.000, 0.994, -72.000, 127, 234 },
    },

    [xi.zone.DYNAMIS_WINDURST] =
    {
        beatVar   = 'DynaWindurst_Win',
        beatKI    = xi.ki.HYDRA_CORPS_LANTERN,
        beatTitle = xi.title.DYNAMIS_WINDURST_INTERLOPER,
        entryPos  = { -221.988, 1.000, -120.184, 0 },
        ejectPos  = { -217.000, 1.000, -119.000, 94, 239 },
    },

    [xi.zone.DYNAMIS_JEUNO] =
    {
        beatVar   = 'DynaJeuno_Win',
        beatKI    = xi.ki.HYDRA_CORPS_TACTICAL_MAP,
        beatTitle = xi.title.DYNAMIS_JEUNO_INTERLOPER,
        entryPos  = { 48.930, 10.002, -71.032, 195 },
        ejectPos  = { 48.930, 10.002, -71.032, 195, 243 },
    },

    [xi.zone.DYNAMIS_BEAUCEDINE] =
    {
        beatVar   = 'DynaBeaucedine_Win',
        beatKI    = xi.ki.HYDRA_CORPS_INSIGNIA,
        beatTitle = xi.title.DYNAMIS_BEAUCEDINE_INTERLOPER,
        entryPos  = { -284.751, -39.923, -422.948, 235 },
        ejectPos  = { -284.751, -39.923, -422.948, 235, 111 },
    },

    [xi.zone.DYNAMIS_XARCABARD] =
    {
        beatVar   = 'DynaXarcabard_Win',
        beatKI    = xi.ki.HYDRA_CORPS_BATTLE_STANDARD,
        beatTitle = xi.title.DYNAMIS_XARCABARD_INTERLOPER,
        entryPos  = { 569.312, -0.098, -270.158, 90 },
        ejectPos  = { 569.312, -0.098, -270.158, 90, 112 },
    },

    [xi.zone.DYNAMIS_VALKURM] =
    {
        beatVar   = 'DynaValkurm_Win',
        beatKI    = xi.ki.DYNAMIS_VALKURM_SLIVER,
        beatTitle = xi.title.DYNAMIS_VALKURM_INTERLOPER,
        entryPos  = { 100, -8, 131, 47 },
        ejectPos  = { 119, -9, 131, 52, 103 },
    },

    [xi.zone.DYNAMIS_BUBURIMU] =
    {
        beatVar   = 'DynaBuburimu_Win',
        beatKI    = xi.ki.DYNAMIS_BUBURIMU_SLIVER,
        beatTitle = xi.title.DYNAMIS_BUBURIMU_INTERLOPER,
        entryPos  = { 155, -1, -169, 170 },
        ejectPos  = { 154, -1, -170, 190, 118 },
    },

    [xi.zone.DYNAMIS_QUFIM] =
    {
        beatVar   = 'DynaQufim_Win',
        beatKI    = xi.ki.DYNAMIS_QUFIM_SLIVER,
        beatTitle = xi.title.DYNAMIS_QUFIM_INTERLOPER,
        entryPos  = { -19, -17, 104, 253 },
        ejectPos  = { 18, -19, 162, 240, 126 },
    },

    [xi.zone.DYNAMIS_TAVNAZIA] =
    {
        beatVar   = 'DynaTavnazia_Win',
        beatKI    = xi.ki.DYNAMIS_TAVNAZIA_SLIVER,
        beatTitle = xi.title.DYNAMIS_TAVNAZIA_INTERLOPER,
        entryPos  = { 0.1, -7, -21, 190 },
        ejectPos  = { 0, -7, -23, 195, 26 },
    },
}

-----------------------------------
-- local functions
-----------------------------------

local function arg3(player, bit)
    local csVar  = player:getCharVar('Dynamis_Status')
    local timeKI = player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE) and 65536 or 0

    if csVar == 0 then
        return 1 + timeKI -- first time visiting any dynamis zone
    elseif not utils.mask.getBit(csVar, bit) then
        return 2 + timeKI -- first time visiting this dynamis zone
    else
        return 3 + timeKI -- have visited this dynamis zone more than once
    end
end

local function handleEntryTime(player)
    local realDay = os.time()

    if xi.settings.main.DYNA_MIDNIGHT_RESET then
        realDay = getMidnight() - 86400
    end

    local dynaWaitxDay = player:getCharVar('dynaWaitxDay')

    if
        (dynaWaitxDay + xi.settings.main.BETWEEN_2DYNA_WAIT_TIME * 60 * 60) < realDay and
        not player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE)
    then
        player:setCharVar('dynaWaitxDay', realDay)
    end
end

-----------------------------------
-- global functions
-----------------------------------
xi.dynamis.entryNpcOnTrigger = function(player, npc)
    local zoneId        = player:getZoneID()
    local info          = entryInfo[zoneId]
    local ID            = zones[zoneId]
    local dynaMask      = player:getCharVar('Dynamis_Status')
    local unlockingDyna = utils.mask.getBit(dynaMask, 0)
    local tavnaziaFirst = false

    -- Tavnazia is unique;  plays the first time cs directly on trigger without message or transporting
    if
        info.csBit == 10 and
        info.reqs(player) and
        not utils.mask.getBit(dynaMask, info.csBit)
    then
        player:startEvent(info.csFirst)
        player:setCharVar('Dynamis_Status', utils.mask.setBit(dynaMask, info.csBit, true))
        -- set to skip menu after getting this CS
        tavnaziaFirst = not tavnaziaFirst
    -- player has access but is on a job below required level
    elseif
        player:hasKeyItem(xi.ki.PRISMATIC_HOURGLASS) and
        player:getMainLvl() < xi.settings.main.DYNA_LEVEL_MIN
    then
        player:messageSpecial(ID.text.PLAYERS_HAVE_NOT_REACHED_LEVEL)
    -- default message always prints except in cases above and not for shrouded sand or winning cs
    elseif not unlockingDyna and player:getCharVar(info.beatVar) ~= 1 then
        player:messageSpecial(ID.text.DYNA_NPC_DEFAULT_MESSAGE)
    end

    -- all cutscenes and menus are blocked behind base requirements; 'unlockingDyna' needs to be checked to access shroud cs after zoning into xarcabard
    if
        not tavnaziaFirst and
        player:getMainLvl() >= xi.settings.main.DYNA_LEVEL_MIN and
        (player:hasKeyItem(xi.ki.PRISMATIC_HOURGLASS) or unlockingDyna)
    then

        -- shrouded sand cutscene
        if
            unlockingDyna and
            info.csVial and
            not player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND)
        then
            player:startEvent(info.csVial)

        -- victory cutscene
        elseif player:getCharVar(info.beatVar) == 1 then
            -- NOTE: The hourglass and shrouded sand parameter is only required for Beaucedine, but has no
            -- effect on the others.
            player:startEvent(info.csBeat, info.beatKI, 0, xi.ki.PRISMATIC_HOURGLASS , xi.ki.VIAL_OF_SHROUDED_SAND)

        -- dynamis entry
        elseif not info.reqs or info.reqs(player) then
            local realDay      = os.time()
            local dynaWaitxDay = player:getCharVar('dynaWaitxDay')
            local sjobOption   = info.csBit > 6 and 1 or 0

            if (dynaWaitxDay + xi.settings.main.BETWEEN_2DYNA_WAIT_TIME * 60 * 60) < realDay then
                -- params: bit, cutscene option, Prismatic Hourglass KI, sJob option, junk, Shrouded Sand KI, Timeless Hourglass item ID, Perpetual Hourglass item ID
                player:startEvent(info.csMenu, info.csBit, arg3(player, info.csBit), xi.ki.PRISMATIC_HOURGLASS, sjobOption, 0, xi.ki.VIAL_OF_SHROUDED_SAND, 4236, 4237)
            else
                local dayRemaining = math.floor(((dynaWaitxDay + xi.settings.main.BETWEEN_2DYNA_WAIT_TIME * 60 * 60) - realDay) / 3456)
                player:messageSpecial(ID.text.YOU_CANNOT_ENTER_DYNAMIS, dayRemaining, info.csBit)
            end
        end
    end
end

xi.dynamis.entryNpcOnEventFinish = function(player, csid, option, npc)
    local info     = entryInfo[player:getZoneID()]
    local dynaMask = player:getCharVar('Dynamis_Status')

    -- shrouded sand cutscene
    if info.csVial and csid == info.csVial then
        npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_SHROUDED_SAND)
        player:setCharVar('Dynamis_Status', utils.mask.setBit(dynaMask, 0, false))

    -- victory cutscene
    elseif csid == info.csBeat then
        player:setCharVar(info.beatVar, 0)

    -- dynamis entry; the check for csFirst is needed, see below
    elseif
        csid == info.csMenu and
        (option == 0 or option == 1) or
        csid == info.csFirst
    then
        player:setCharVar('Dynamis_subjob', option)
        player:setCharVar('Dynamis_Entry', 1)
        player:setCharVar('Dynamis_Status', utils.mask.setBit(dynaMask, info.csBit, true))

        handleEntryTime(player)

        -- first visit cutscene plays after choosing to enter, except Tavnazia as seen above
        if not utils.mask.getBit(dynaMask, info.csBit) then
            player:startEvent(info.csFirst) -- this will loop back to this same block to trigger setPos
        end

        player:setPos(unpack(info.enterPos))
    end
end

xi.dynamis.zoneOnInitialize = function(zone)
    local zoneId            = zone:getID()
    local ID                = zones[zoneId]
    local timeExtensionMobs = ID.mob.TIME_EXTENSION
    local refillMobs        = ID.mob.REFILL_STATUE

    -- spawn one of each grouped TEs
    if timeExtensionMobs then
        for _, v in pairs(timeExtensionMobs) do
            local group = {}

            if type(v.mob) == 'number' then
                group = { v.mob }
            elseif type(v.mob) == 'table' then
                group = { unpack(v.mob) }
            end

            local teId = group[math.random(1, #group)]
            DisallowRespawn(teId, false)
            SpawnMob(teId)
        end
    end

    -- spawn one of each grouped refill statue
    if refillMobs then
        for _, g in pairs(refillMobs) do
            local group = {}

            for _, m in pairs(g) do
                table.insert(group, m.mob)
            end

            local spawnId = group[math.random(1, #group)]
            DisallowRespawn(spawnId, false)
            SpawnMob(spawnId)
        end
    end

    for _, mob in pairs(zone:getMobs()) do
        mob:setCarefulPathing(true)
    end
end

xi.dynamis.zoneOnZoneIn = function(player, prevZone)
    local zoneId = player:getZoneID()
    local info   = dynaInfo[zoneId]
    local ID     = zones[zoneId]

    local cs = -1

    if player:getCharVar('Dynamis_Entry') == 1 or player:getGMLevel() > 0 then
        if player:getCharVar('Dynamis_subjob') == 1 then
            player:timer(5000, function(playerArg)
                playerArg:messageBasic(xi.msg.basic.UNABLE_TO_ACCESS_SJ)
            end)

            player:addStatusEffect(xi.effect.SJ_RESTRICTION, 0, 0, 0, 0, 0)
        end

        player:addStatusEffectEx(xi.effect.DYNAMIS, 0, 0, 3, 3600)
        player:timer(5500, function(playerArg)
            playerArg:messageSpecial(ID.text.DYNAMIS_TIME_BEGIN, 60, xi.ki.PRISMATIC_HOURGLASS)
        end)

        player:setCharVar('Dynamis_Entry', 0)
        player:setCharVar('Dynamis_subjob', 0)
    end

    if not player:hasStatusEffect(xi.effect.DYNAMIS) then
        cs = 100 -- eject event (same event in all dynamis zones)
    elseif
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(unpack(info.entryPos))
    end

    return cs
end

xi.dynamis.zoneOnEventFinish = function(player, csid, option, npc)
    local zoneId = player:getZoneID()
    local info   = dynaInfo[zoneId]

    if csid == 100 then
        player:setPos(unpack(info.ejectPos))
    end
end

xi.dynamis.somnialThresholdOnTrigger = function(player, npc)
    -- ability to unlock SJ message
    local canUnlockSJ = player:hasStatusEffect(xi.effect.SJ_RESTRICTION) and 1 or 0

    -- bitmask controls options in the menu. 1 = Leave Dynamis.  2 = Unlock support jobs.  4 = Nothing (quit menu)
    local menuBits = 5 + (canUnlockSJ * 2)

    player:startEvent(101, 0x27, canUnlockSJ, menuBits)
end

xi.dynamis.somnialThresholdOnEventFinish = function(player, csid, option, npc)
    local zoneId = player:getZoneID()
    local info   = dynaInfo[zoneId]
    local ID     = zones[zoneId]

    if csid == 100 then
        player:setPos(unpack(info.ejectPos))
    elseif option == 1 then
        player:startEvent(100)
    elseif option == 2 then
        player:messageSpecial(ID.text.DYNAMIS_SUB_UNLOCKED)
        player:delStatusEffectSilent(xi.effect.SJ_RESTRICTION)
    end
end

xi.dynamis.megaBossOnDeath = function(mob, player, optParams)
    local zoneId = player:getZoneID()
    local info   = dynaInfo[zoneId]

    player:addTitle(info.beatTitle)

    if not player:hasKeyItem(info.beatKI) then
        npcUtil.giveKeyItem(player, info.beatKI)
        player:setCharVar(info.beatVar, 1)
    end
end

xi.dynamis.timeExtensionOnDeath = function(mob, player, optParams)
    local mobId             = mob:getID()
    local zoneId            = mob:getZoneID()
    local ID                = zones[zoneId]
    local timeExtensionMobs = ID.mob.TIME_EXTENSION

    if timeExtensionMobs then
        local found = false
        local te    = nil
        local group = {}

        -- find this TE's group
        for _, t in pairs(timeExtensionMobs) do
            if type(t.mob) == 'number' then
                group = { t.mob }
            elseif type(t.mob) == 'table' then
                group = { unpack(t.mob) }
            end

            for _, g in pairs(group) do
                if g == mobId then
                    found = true
                    te    = t
                    break
                end
            end

            if found then
                break
            end
        end

        -- TODO: Refactor the above loops to not need the 'found' variable, and only use
        -- non-nil te value.
        if
            found and
            te
        then
            -- award KI and extension to those who have not yet received it
            local effect = player:getStatusEffect(xi.effect.DYNAMIS)
            if effect and not player:hasKeyItem(te.ki) then
                npcUtil.giveKeyItem(player, te.ki)
                local oldDuration = effect:getDuration()
                effect:setDuration((oldDuration + (te.minutes * 60)) * 1000)
                player:setLocalVar('dynamis_lasttimeupdate', effect:getTimeRemaining() / 1000)
                player:messageSpecial(ID.text.DYNAMIS_TIME_EXTEND, te.minutes)
            end

            -- spawn a new mob in this group
            if optParams.isKiller then
                local teId = group[math.random(1, #group)]
                if teId ~= mobId then
                    DisallowRespawn(mobId, true)
                    DisallowRespawn(teId, false)
                end

                GetMobByID(teId):setRespawnTime(85)
            end
        else
            printf('[xi.dynamis.timeExtensionOnDeath] called in zone %i on mob %s that does not appear in a time extension group.', zoneId, mob:getName())
        end
    else
        printf('[xi.dynamis.timeExtensionOnDeath] called on mob %s in zone %i that does not have a TIME_EXTENSION table in its IDs.', mob:getName(), zoneId)
    end
end

xi.dynamis.refillStatueOnSpawn = function(mob)
    local mobId      = mob:getID()
    local zoneId     = mob:getZoneID()
    local ID         = zones[zoneId]
    local refillMobs = ID.mob.REFILL_STATUE

    if refillMobs then
        local found = false

        -- set this statue's eye color
        for _, g in pairs(refillMobs) do
            for _, m in pairs(g) do
                if m.mob == mobId then
                    found = true
                    mob:setAnimationSub(m.eye)
                    break
                end
            end

            if found then
                break
            end
        end

        if not found then
            printf('[xi.dynamis.refillStatueOnSpawn] called in zone %i on mob %i that does not appear in a refill statue group.', zoneId, mobId)
        end
    else
        printf('[xi.dynamis.refillStatueOnSpawn] called on mob %i in zone %i that does not have a REFILL_STATUE table in its IDs.', mobId, zoneId)
    end
end

xi.dynamis.refillStatueOnDeath = function(mob, player, optParams)
    local mobId      = mob:getID()
    local zoneId     = mob:getZoneID()
    local ID         = zones[zoneId]
    local refillMobs = ID.mob.REFILL_STATUE

    if refillMobs then
        local found = false
        local group = {}
        local eye   = nil

        -- find this statue's group and eye color
        for _, g in pairs(refillMobs) do
            group = {}
            for _, m in pairs(g) do
                table.insert(group, m.mob)
                if m.mob == mobId then
                    found = true
                    eye = m.eye
                end
            end

            if found then
                break
            end
        end

        if found then
            if optParams.isKiller then
                -- MP or HP refill
                if eye == xi.dynamis.eye.BLUE or eye == xi.dynamis.eye.GREEN then
                    local zone    = mob:getZone()
                    local players = zone:getPlayers()

                    for name, playerObj in pairs(players) do
                        if mob:checkDistance(playerObj) < 30 then
                            if eye == xi.dynamis.eye.BLUE then
                                local amt = playerObj:getMaxMP() - playerObj:getMP()
                                playerObj:restoreMP(amt)
                                playerObj:messageBasic(xi.msg.basic.RECOVERS_MP, 0, amt)
                            else
                                local amt = playerObj:getMaxHP() - playerObj:getHP()
                                playerObj:restoreHP(amt)
                                playerObj:messageBasic(xi.msg.basic.RECOVERS_HP, 0, amt)
                            end
                        end
                    end
                end

                mob:setAnimationSub(xi.dynamis.eye.NONE)

                -- spawn a new mob in this group
                local nextId = group[math.random(1, #group)]
                if nextId ~= mobId then
                    DisallowRespawn(mobId, true)
                    DisallowRespawn(nextId, false)
                end

                GetMobByID(nextId):setRespawnTime(300) -- 5 minutes
            end
        else
            printf('[xi.dynamis.refillStatueOnDeath] called in zone %i on mob %i that does not appear in a refill statue group.', zoneId, mobId)
        end
    else
        printf('[xi.dynamis.refillStatueOnDeath] called on mob %i in zone %i that does not have a REFILL_STATUE table in its IDs.', mobId, zoneId)
    end
end

xi.dynamis.qmOnTrade = function(player, npc, trade)
    local npcId  = npc:getID()
    local zoneId = npc:getZoneID()
    local ID     = zones[zoneId]
    local qmNpcs = ID.npc.QM

    if qmNpcs then
        local info = qmNpcs[npcId]

        if info then
            for _, v in pairs(info.trade) do
                if npcUtil.tradeHasExactly(trade, v.item) then
                    local mobId

                    if type(v.mob) == 'table' then
                        mobId = v.mob[math.random(1, #v.mob)]
                    else
                        mobId = v.mob
                    end

                    if
                        mobId and
                        npcUtil.popFromQM(player, npc, mobId, { hide = 0, radius = 2 })
                    then
                        player:confirmTrade()
                    end

                    break
                end
            end
        else
            printf('[xi.dynamis.qmOnTrade] called on in zone %i on npc %i (%s) that does not appear in QM data.', zoneId, npcId, npc:getName())
        end
    else
        printf('[xi.dynamis.qmOnTrade] called on npc %i (%s) in zone %i that does not have a QM group in its IDs.', npcId, npc:getName(), zoneId)
    end
end

xi.dynamis.qmOnTrigger = function(player, npc)
    local npcId  = npc:getID()
    local zoneId = npc:getZoneID()
    local ID     = zones[zoneId]
    local qmNpcs = ID.npc.QM

    if qmNpcs then
        local info = qmNpcs[npcId]

        if info then
            if info.param then
                player:startEvent(102, unpack(info.param))
            elseif
                info.trade and
                #info.trade == 1 and
                info.trade[1].item and
                type(info.trade[1].item) == 'number' and
                ID.text.OMINOUS_PRESENCE
            then
                player:messageSpecial(ID.text.OMINOUS_PRESENCE, info.trade[1].item)
            end
        else
            printf('[xi.dynamis.qmOnTrigger] called on in zone %i on npc %i (%s) that does not appear in QM data.', zoneId, npcId, npc:getName())
        end
    else
        printf('[xi.dynamis.qmOnTrigger] called on npc %i (%s) in zone %i that does not have a QM group in its IDs.', npcId, npc:getName(), zoneId)
    end
end

-----------------------------------
-- xi.dynamis.getDynamisMapList
-- Produces a bitmask for the goblin ancient currency NPCs
-----------------------------------

local dynamisMapKI =
{
    xi.ki.MAP_OF_DYNAMIS_SAN_DORIA,
    xi.ki.MAP_OF_DYNAMIS_BASTOK,
    xi.ki.MAP_OF_DYNAMIS_WINDURST,
    xi.ki.MAP_OF_DYNAMIS_JEUNO,
    xi.ki.MAP_OF_DYNAMIS_BEAUCEDINE,
    xi.ki.MAP_OF_DYNAMIS_XARCABARD,
    xi.ki.MAP_OF_DYNAMIS_VALKURM,
    xi.ki.MAP_OF_DYNAMIS_BUBURIMU,
    xi.ki.MAP_OF_DYNAMIS_QUFIM,
    xi.ki.MAP_OF_DYNAMIS_TAVNAZIA,
}

xi.dynamis.getDynamisMapList = function(player)
    local bitmask = 0

    for position, keyItem in ipairs(dynamisMapKI) do
        if player:hasKeyItem(keyItem) then
            bitmask = bitmask + bit.lshift(1, position)
        end
    end

    return bitmask
end

-- todo: fix these to use tables
local function getExtensions(player)
    local count = 0

    for i = xi.ki.CRIMSON_GRANULES_OF_TIME, xi.ki.OBSIDIAN_GRANULES_OF_TIME do
        if player:hasKeyItem(i) then
            count = count + 1
        end
    end

    return count
end

xi.dynamis.procMonster = function(mob, player)
    if player and player:getAllegiance() == 1 then
        local master = player:getMaster()
        if master then
            player = master
        end

        local extensions = getExtensions(player)
        if extensions > 2 then
            if
                player:hasStatusEffect(xi.effect.SJ_RESTRICTION) and
                math.random(1, 100) == 1
            then
                mob:setLocalVar('dynamis_proc', 4)
                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 30)
                mob:weaknessTrigger(3)
            elseif extensions == 5 then
                mob:setLocalVar('dynamis_proc', 3)
                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 30)
                mob:weaknessTrigger(2)
            elseif extensions == 4 then
                mob:setLocalVar('dynamis_proc', 2)
                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 30)
                mob:weaknessTrigger(1)
            elseif extensions == 3 then
                mob:setLocalVar('dynamis_proc', 1)
                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 30)
                mob:weaknessTrigger(0)
            end
        end
    end
end

xi.dynamis.hourglassAndCurrencyExchangeNPCLookup =
{
    -- Haggleblix
    [xi.zone.BEADEAUX] =
    {
        baseCs = 130,
        currency =
        {
            xi.item.ONE_BYNE_BILL,
            xi.item.ONE_HUNDRED_BYNE_BILL,
            xi.item.TEN_THOUSAND_BYNE_BILL,
        },
        shop =
        {
            7,  xi.item.LOCK_OF_SIRENS_HAIR,
            8,  xi.item.VIAL_OF_SLIME_JUICE,
            9,  xi.item.CHUNK_OF_WOOTZ_ORE,
            12, xi.item.BOTTLE_OF_CANTARELLA,
            20, xi.item.FLASK_OF_MARKSMANS_OIL,
            25, xi.item.WOOTZ_INGOT,
            33, xi.item.KOH_I_NOOR,
        }
    },
    -- Antiquix
    [xi.zone.CASTLE_OZTROJA] =
    {
        baseCs = 50,
        currency =
        {
            xi.item.TUKUKU_WHITESHELL,
            xi.item.LUNGO_NANGO_JADESHELL,
            xi.item.RIMILALA_STRIPESHELL,
        },
        shop =
        {
            7,  xi.item.PIECE_OF_ANGEL_SKIN,
            8,  xi.item.COLOSSAL_SKULL,
            9,  xi.item.LANCEWOOD_LOG,
            23, xi.item.CHRONOS_TOOTH,
            24, xi.item.CHUNK_OF_RELIC_STEEL,
            25, xi.item.PIECE_OF_LANCEWOOD_LUMBER,
            28, xi.item.DAMASCUS_INGOT,
        }
    },
    -- Lootblox
    [xi.zone.DAVOI] =
    {
        baseCs = 130,
        currency =
        {
            xi.item.ORDELLE_BRONZEPIECE,
            xi.item.MONTIONT_SILVERPIECE,
            xi.item.RANPERRE_GOLDPIECE,
        },
        shop =
        {
            5,  xi.item.TWINCOON,
            6,  xi.item.PILE_OF_RELIC_IRON,
            7,  xi.item.JAR_OF_GOBLIN_GREASE,
            8,  xi.item.GRIFFON_HIDE,
            23, xi.item.SQUARE_OF_GRIFFON_LEATHER,
            25, xi.item.BEHEMOTH_HORN,
            28, xi.item.MAMMOTH_TUSK,
        }
    },
}

xi.dynamis.mapShopCosts =
{
    [xi.ki.MAP_OF_DYNAMIS_SAN_DORIA]  = 10000,
    [xi.ki.MAP_OF_DYNAMIS_BASTOK]     = 10000,
    [xi.ki.MAP_OF_DYNAMIS_WINDURST]   = 10000,
    [xi.ki.MAP_OF_DYNAMIS_JEUNO]      = 10000,
    [xi.ki.MAP_OF_DYNAMIS_BEAUCEDINE] = 15000,
    [xi.ki.MAP_OF_DYNAMIS_XARCABARD]  = 20000,
    [xi.ki.MAP_OF_DYNAMIS_VALKURM]    = 10000,
    [xi.ki.MAP_OF_DYNAMIS_BUBURIMU]   = 10000,
    [xi.ki.MAP_OF_DYNAMIS_QUFIM]      = 10000,
    [xi.ki.MAP_OF_DYNAMIS_TAVNAZIA]   = 20000,
}

xi.dynamis.hourglassAndCurrencyExchangeNPCOnTrade = function(player, npc, trade)
    local gil       = trade:getGil()
    local count     = trade:getItemCount()
    local tradeItem = trade:getItemId(0)

    local zoneId   = player:getZoneID()
    local baseCs   = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].baseCs
    local currency = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].currency
    local shop     = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].shop

    -- Zero this out, just in case
    player:setLocalVar('currencyExchange', 0)

    if player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) then
        -- buy prismatic hourglass
        if
            gil == xi.settings.main.PRISMATIC_HOURGLASS_COST and
            count == 1 and
            not player:hasKeyItem(xi.ki.PRISMATIC_HOURGLASS)
        then
            player:startEvent(baseCs + 4)

        -- return timeless hourglass for refund
        elseif count == 1 and trade:hasItemQty(xi.item.TIMELESS_HOURGLASS, 1) then
            player:startEvent(baseCs + 23)

        -- currency exchanges
        elseif -- 1's -> 100's
            count == xi.settings.main.CURRENCY_EXCHANGE_RATE and
            trade:hasItemQty(currency[1], xi.settings.main.CURRENCY_EXCHANGE_RATE)
        then
            player:startEvent(baseCs + 5, xi.settings.main.CURRENCY_EXCHANGE_RATE)
        elseif -- 100's -> 10'000's
            count == xi.settings.main.CURRENCY_EXCHANGE_RATE and
            trade:hasItemQty(currency[2], xi.settings.main.CURRENCY_EXCHANGE_RATE)
        then
            player:startEvent(baseCs + 6, xi.settings.main.CURRENCY_EXCHANGE_RATE)
        elseif -- 10'000's to 100's
            count == 1 and
            trade:hasItemQty(currency[3], 1) and
            tradeItem == currency[3]
        then
            player:setLocalVar('currencyExchange', currency[2])
            player:startEvent(baseCs + 8, tradeItem, currency[2], xi.settings.main.CURRENCY_EXCHANGE_RATE)
        elseif -- (optional) 100's to 1's
            xi.settings.main.ENABLE_EXCHANGE_100S_TO_1S and
            count == 1 and
            trade:hasItemQty(currency[2], 1) and
            tradeItem == currency[2]
        then
            player:setLocalVar('currencyExchange', currency[1])
            player:startEvent(baseCs + 8, tradeItem, currency[1], xi.settings.main.CURRENCY_EXCHANGE_RATE)

        -- shop
        else
            local item
            local price
            for i = 1, 13, 2 do
                price = shop[i]
                item = shop[i + 1]
                if count == price and trade:hasItemQty(currency[2], price) then
                    player:setLocalVar('hundredItemBought', item)
                    player:startEvent(baseCs + 7, currency[2], price, item)
                    break
                end
            end
        end
    end
end

xi.dynamis.hourglassAndCurrencyExchangeNPCOnTrigger = function(player, npc)
    local zoneId   = player:getZoneID()
    local baseCs   = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].baseCs
    local currency = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].currency

    if player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) then
        player:startEvent(baseCs + 3, currency[1], xi.settings.main.CURRENCY_EXCHANGE_RATE, currency[2], xi.settings.main.CURRENCY_EXCHANGE_RATE, currency[3], xi.settings.main.PRISMATIC_HOURGLASS_COST, xi.item.TIMELESS_HOURGLASS, xi.settings.main.TIMELESS_HOURGLASS_COST)
    else
        player:startEvent(baseCs + 0)
    end
end

xi.dynamis.hourglassAndCurrencyExchangeNPCOnEventUpdate = function(player, csid, option, npc)
    local zoneId   = player:getZoneID()
    local ID       = zones[zoneId]
    local baseCs   = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].baseCs
    local currency = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].currency
    local shop     = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].shop

    if csid == baseCs + 3 then
        -- asking about hourglasses
        if option == 1 then
            if not player:hasItem(xi.item.TIMELESS_HOURGLASS) then
                -- must figure out what changes here to prevent the additional dialog
                -- player:updateEvent(?)
            end

        -- shop
        elseif option == 2 then
            player:updateEvent(unpack(shop, 1, 8))
        elseif option == 3 then
            player:updateEvent(unpack(shop, 9, 14))

        -- offer to trade down from a 10k
        elseif option == 10 then
            player:updateEvent(currency[3], currency[2], xi.settings.main.CURRENCY_EXCHANGE_RATE)

        -- main menu (param1 = dynamis map bitmask, param2 = gil)
        elseif option == 11 then
            player:updateEvent(xi.dynamis.getDynamisMapList(player), player:getGil())

        -- maps
        elseif xi.dynamis.mapShopCosts[option] ~= nil then
            local price = xi.dynamis.mapShopCosts[option]
            if price > player:getGil() then
                player:messageSpecial(ID.text.NOT_ENOUGH_GIL)
            else
                player:delGil(price)
                npcUtil.giveKeyItem(player, option)
            end

            player:updateEvent(xi.dynamis.getDynamisMapList(player), player:getGil())
        end
    end
end

xi.dynamis.hourglassAndCurrencyExchangeNPCOnEventFinish = function(player, csid, option, npc)
    local zoneId   = player:getZoneID()
    local ID       = zones[zoneId]
    local baseCs   = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].baseCs
    local currency = xi.dynamis.hourglassAndCurrencyExchangeNPCLookup[zoneId].currency

    -- bought prismatic hourglass
    if csid == baseCs + 4 then
        player:tradeComplete()
        npcUtil.giveKeyItem(player, xi.ki.PRISMATIC_HOURGLASS)

    -- refund timeless hourglass
    elseif csid == baseCs + 13 then
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', xi.settings.main.TIMELESS_HOURGLASS_COST)

    -- singles to hundreds
    elseif csid == baseCs + 5 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, currency[2])
        else
            player:tradeComplete()
            player:addItem(currency[2])
            player:messageSpecial(ID.text.ITEM_OBTAINED, currency[2])
        end

    -- hundreds to 10k pieces
    elseif csid == baseCs + 6 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, currency[3])
        else
            player:tradeComplete()
            player:addItem(currency[3])
            player:messageSpecial(ID.text.ITEM_OBTAINED, currency[3])
        end

    -- 10k pieces to hundreds (or hundreds to singles)
    elseif csid == baseCs + 8 then
        local currencyExchange = player:getLocalVar('currencyExchange')
        local slotsReq         = math.ceil(xi.settings.main.CURRENCY_EXCHANGE_RATE / 99)
        if player:getFreeSlotsCount() < slotsReq then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, currencyExchange)
        else
            player:tradeComplete()
            for i = 1, slotsReq do
                if i < slotsReq or (xi.settings.main.CURRENCY_EXCHANGE_RATE % 99) == 0 then
                    player:addItem(currencyExchange, 99)
                else
                    player:addItem(currencyExchange, xi.settings.main.CURRENCY_EXCHANGE_RATE % 99)
                end
            end

            player:messageSpecial(ID.text.ITEMS_OBTAINED, currencyExchange, xi.settings.main.CURRENCY_EXCHANGE_RATE)
        end

        -- Zero this out, just in case
        player:setLocalVar('currencyExchange', 0)

    -- bought item from shop
    elseif csid == baseCs + 7 then
        local item = player:getLocalVar('hundredItemBought')
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            player:tradeComplete()
            player:addItem(item)
            player:messageSpecial(ID.text.ITEM_OBTAINED, item)
        end

        player:setLocalVar('hundredItemBought', 0)
    end
end
