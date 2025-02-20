-----------------------------------
-- Instance
-----------------------------------
-- TOAU storyline missions
-- Salvage
-- WOTG storyline missions
-- Certain Campaign Ops
-- Moblin Maze Mongers
-- The Notorious Monster battles that occur when Sandworm sucks in players using Doomvoid
--
-- Instance zones:
-- - ILRUSI_ATOLL                    = 55,
-- - PERIQIA                         = 56,
-- - THE_ASHU_TALIF                  = 60,
-- - LEBROS_CAVERN                   = 63,
-- - MAMOOL_JA_TRAINING_GROUNDS      = 66,
-- - LEUJAOAM_SANCTUM                = 69,
-- - ZHAYOLM_REMNANTS                = 73,
-- - ARRAPAGO_REMNANTS               = 74,
-- - BHAFLAU_REMNANTS                = 75,
-- - SILVER_SEA_REMNANTS             = 76,
-- - NYZUL_ISLE                      = 77,
-- - EVERBLOOM_HOLLOW                = 86,
-- - RUHOTZ_SILVERMINES              = 93,
-- - GHOYUS_REVERIE                  = 129,
-- - MAQUETTE_ABDHALJS_LEGION_A      = 183,
-- - RALA_WATERWAYS_U                = 259,
-- - YORCIA_WEALD_U                  = 264,
-- - CIRDAS_CAVERNS_U                = 271,
-- - OUTER_RAKAZNAR_U1               = 275,
-- - MAQUETTE_ABDHALJS_LEGION_B      = 287, -- See: ambuscade.lua
-- - DYNAMIS_SAN_DORIA_D             = 294,
-- - DYNAMIS_BASTOK_D                = 295,
-- - DYNAMIS_WINDURST_D              = 296,
-- - DYNAMIS_JEUNO_D                 = 297,
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.instance = {}

--[[
    [zoneId] =
    {
        {
            instanceIdInDatabase,
            onTrigger startEvent args (to be unpacked),
            onEventFinish valid entry args for registrant (to be unpacked),
            event args for joining party members (to be unpacked)
        }
    },
--]]

xi.instance.lookup =
{
    [xi.zone.ILRUSI_ATOLL] =
    {
        -- Assault: Golden Salvage
        -- Assault: Lamia No.13
        -- Assault: Extermination
        -- Assault: Demolition Duty
        -- Assault: Searat Salvation
        -- Assault: Apkallu Seizure
        -- Assault: Lost and Found
        -- Assault: Deserter
        -- Assault: Desperately Seeking Cephalopods
        -- Assault: Bellerophon's Bliss
    },

    [xi.zone.PERIQIA] =
    {
        { 5600, { 143, 79, -6, 0, 99, 3, 0 }, { 143, 4 }, { 147, 3 } }, -- Shades of Vengeance (TOAU31)
        { 5601, { 143, 31, -4, 0, 70, 0, 1 }, { 143, 4 }, { 147, 0 } }, -- Assault: Seagull Grounded
        -- Assault: Requiem
        -- Assault: Saving Private Ryaaf
        -- Assault: Shooting Down the Baron
        -- Assault: Stop the Bloodshed
        -- Assault: Defuse the Threat
        -- Assault: Operation: Snake Eyes
        -- Assault: Wake the Puppet
        -- Assault: The Price is Right
    },

    [xi.zone.THE_ASHU_TALIF] =
    {
        { 6000, { 221, 53, -6, 0, 99, 6, 0 }, { 221, 4 }, { 222, 6 } }, -- The Black Coffin (TOAU 15)
        { 6001, { 221, 54, -9, 0, 99, 6, 0 }, { 221, 4 }, { 222, 6 } }, -- Against All Odds
        -- Testing the Waters (TOAU 34)
        -- Legacy of the Lost (TOAU 35)
        -- Assault: Royal Painter Escort
        -- Assault: Scouting the Ashu Talif
        -- Assault: Targeting the Captain
    },

    [xi.zone.LEBROS_CAVERN] =
    {
        { 6300, { 203, 21, -4, 0, 50, 0, 1 }, { 203, 4 }, { 208, 0 } }, -- Assault: Excavation Duty
        -- Assault: Lebros Supplies
        -- Assault: Troll Fugitives
        -- Assault: Evade and Escape
        -- Assault: Siegemaster Assassination
        -- Assault: Apkallu Breeding
        -- Assault: Wamoura Farm Raid
        -- Assault: Egg Conservation
        -- Assault: Operation: Black Pearl
        -- Assault: Better Than One
    },

    [xi.zone.MAMOOL_JA_TRAINING_GROUNDS] =
    {
        { 6600, { 505, 11, -4, 0, 60, 0, 1 }, { 505, 4 }, { 511, 0 } }, -- Assault: Imperial Agent Rescue
        -- Assault: Preemptive Strike
        -- Assault: Sagelord Elimination
        -- Assault: Breaking Morale
        -- Assault: The Double Agent
        -- Assault: Imperial Treasure Retrieval
        -- Assault: Blitzkrieg
        -- Assault: Marids in the Mist
        -- Assault: Azure Ailments
        -- Assault: The Susanoo Shuffle
    },

    [xi.zone.LEUJAOAM_SANCTUM] =
    {
        { 6900, { 140, 1, -4, 0, 50, 0, 1 }, { 140, 4 }, { 147, 0 } }, -- Assault: Leujaoam Cleansing
        -- Assault: Orichalcum Survey
        -- Assault: Escort Professor Chanoix
        -- Assault: Shanarha Grass Conservation
        -- Assault: Counting Sheep
        -- Assault: Supplies Recovery
        -- Assault: Azure Experiments
        -- Assault: Imperial Code
        -- Assault: Red Versus Blue
        -- Assault: Bloody Rondo
    },

    [xi.zone.ZHAYOLM_REMNANTS] =
    {
        { 7300, { 407, 0, -6, 0, 0, 7 }, { 407, 4 }, { 411, 7 } }, -- Salvage I, Zhayolm Remnants
    },

    [xi.zone.ARRAPAGO_REMNANTS] =
    {
        { 7400, { 408, 0, -6, 0, 0, 8 }, { 408, 4 }, { 411, 8 } }, -- Salvage I, Arrapago Remnants
    },

    [xi.zone.BHAFLAU_REMNANTS] =
    {
        { 7500, { 409, 0, -6, 0, 0, 9 }, { 409, 4 }, { 411, 9 } }, -- Salvage I, Bhaflau Remnants
    },

    [xi.zone.SILVER_SEA_REMNANTS] =
    {
        { 7600, { 410, 0, -6, 0, 0, 10 }, { 410, 4 }, { 411, 10 } }, -- Salvage I, Silver Sea Remnants
    },

    [xi.zone.NYZUL_ISLE] =
    {
        { 7700, { 405, 58,  -6, 0, 99, 5, 0 }, { 116, 1 }, { 411, 5 } }, -- Path of Darkness
        { 7701, { 405, 59, -10, 0, 99, 5, 0 }, { 116, 1 }, { 411, 5 } }, -- Nashmeira's Plea
        -- Waking the Colossus / Divine Interference
        -- Forging a New Myth
        { 7704, { 405, 51,  -4, 0, 75, 5, 1 }, { 116, 2 }, { 411, 5 } }, -- Nyzul Isle Investigation
    },

    [xi.zone.EVERBLOOM_HOLLOW] =
    {
        -- Honor Under Fire
        -- Bonds That Never Die
        -- A Nation on the Brink
        -- Dungeons and Dancers
        -- Campaign Ops:
        -- Brave Dawn I (San d'Oria)
        -- Brave Dawn II (San d'Oria)
        -- Brave Dawn III (San d'Oria)
        -- Granite Rose I (San d'Oria)
        -- Granite Rose II (San d'Oria)
        -- Granite Rose III (San d'Oria)
        -- Pit Spider I (San d'Oria)
        -- Pit Spider II (San d'Oria)
        -- Pit Spider III (San d'Oria)
        -- Doomvoid - King Arthro
        -- Doomvoid - Lambton Worm
        -- Moblin Maze Mongers
    },

    [xi.zone.RUHOTZ_SILVERMINES] =
    {
        { 9300, {   3, 0, 0, 19 }, {   3, 4 }, {   4, 1 } }, -- Light in the Darkness (WOTG Bastok Quest 3)
        { 9301, { 203, 0, 0, 36 }, { 203, 4 }, { 201, 1 } }, -- Fire in the Hole (WOTG Bastok Quest 6)
        -- { 0, { 0,  0, 34 } }, -- Seeing Blood-red (SCH AF3)
        -- { 0, { 0, 23,  0 } }, -- Distorter of Time
        -- Campaign Ops:
        -- Brave Dawn I (Bastok)
        -- Brave Dawn II (Bastok)
        -- Brave Dawn III (Bastok)
        -- By Light of Fire I (Bastok)
        -- Granite Rose I (Bastok)
        -- Granite Rose II (Bastok)
        -- Granite Rose III (Bastok)
        -- Pit Spider I (Bastok)
        -- Pit Spider II (Bastok)
        -- Doomvoid - Lambton Worm
        -- Doomvoid - Guivre
        -- Moblin Maze Mongers
    },

    [xi.zone.GHOYUS_REVERIE] =
    {
        -- A Feast for Gnats
        -- A Manifest Problem
        -- In a Haze of Glory
        -- Sins of the Mothers
        -- Campaign Ops:
        -- Brave Dawn I (Windurst)
        -- Brave Dawn II (Windurst)
        -- Brave Dawn III (Windurst)
        -- Granite Rose I (Windurst)
        -- Granite Rose II (Windurst)
        -- Pit Spider I (Windurst)
        -- Pit Spider II (Windurst)
        -- Doomvoid - Lambton Worm
        -- Doomvoid - Serket
    },

    [xi.zone.MAQUETTE_ABDHALJS_LEGION_A] =
    {
        -- Hall of An (Leader entry: { 8009, 0, 0, 0, 0, 6, 1 }, Party entry: { 8003, 0, 0, 0, 0, 6, 1 })
        -- Hall of Ki
        -- Hall of Im
        -- Hall of Muru
        -- Hall of Mul
    },

    [xi.zone.RALA_WATERWAYS_U] =
    {
        -- {  0, 0 }, -- Endeavoring to Awaken
        -- {  1, 0 }, -- Endeavoring to Awaken
        -- -- Blank
        { 25900, { 5511, 258, 8 }, { 5511, 8 }, { 258, 8 } }, -- Behind the Sluices
        -- {  4, 0 }, -- Stonewalled
        -- {  5, 0 }, -- The Gates
        -- {  6, 0 }, -- Saved by the Bell
        -- {  7, 0 }, -- Quiescence
        -- {  8, 0 }, -- The Charlatan
        -- {  9, 0 }, -- Yggdrasil Beckons
        -- { 10, 0 }, -- Yggdrasil Beckons
        -- { 11, 0 }, -- Watery Grave
        -- { 12, 0 }, -- Mistress of Ceremonies
        -- { 13, 0 }, -- A Barrel of Laughs
        -- { 14, 0 }, -- Sinister Reign
        -- { 15, 0 }, -- The Ygnas Directive 6
        -- { 16, 0 }, -- Skirmishes
        -- { 17, 0 }, -- Fractures
        -- { 18, 0 }, -- Alluvion skirmishes
        -- { 19, 0 }, -- The Silent Forest
        -- { 20, 0 }, -- Wind of Eternity
    },

    [xi.zone.YORCIA_WEALD_U] =
    {

    },

    [xi.zone.CIRDAS_CAVERNS_U] =
    {

    },

    [xi.zone.OUTER_RAKAZNAR_U1] =
    {

    },

    [xi.zone.DYNAMIS_SAN_DORIA_D] =
    {

    },

    [xi.zone.DYNAMIS_BASTOK_D] =
    {

    },

    [xi.zone.DYNAMIS_WINDURST_D] =
    {

    },

    [xi.zone.DYNAMIS_JEUNO_D] =
    {

    },
}

-- Party leader registering
local checkRegistryReqs = function(player, instanceId)
    local instanceObj = GetCachedInstanceScript(instanceId)
    if type(instanceObj.registryRequirements) == 'function' then
        return instanceObj.registryRequirements(player)
    else
        print('xi.instance: checkReqs: registryRequirements function not set for instance: ' .. instanceId)
        return false
    end
end

-- Further players joining
local checkEntryReqs = function(player, instanceId)
    local instanceObj = GetCachedInstanceScript(instanceId)
    if type(instanceObj.entryRequirements) == 'function' then
        return instanceObj.entryRequirements(player)
    else
        print('xi.instance: checkReqs: entryRequirements function not set for instance: ' .. instanceId)
        return false
    end
end

xi.instance.onTrade = function(player, npc, trade)
end

xi.instance.onTrigger = function(player, npc, instanceZoneID)
    local zoneLookup = xi.instance.lookup[instanceZoneID]

    -- Clear up after possible failed loads
    player:setLocalVar('INSTANCE_REQUESTED', 0)
    local existingInstance = player:getInstance()
    if existingInstance then
        existingInstance:fail()
    end

    -- Find the first instance you're valid for
    -- TODO: Handle being valid for multiple instances from the same entrance
    local chosenEntry
    for _, entry in ipairs(zoneLookup) do
        local instanceId    = entry[1]
        local hasValidEntry = checkRegistryReqs(player, instanceId)

        if hasValidEntry then
            chosenEntry = entry
            break
        end
    end

    if chosenEntry == nil then
        return false
    end

    -- Play the cs + args for that instance
    local instanceId          = chosenEntry[1]
    local instanceTriggerArgs = chosenEntry[2]
    local hasValidEntry       = checkRegistryReqs(player, instanceId)

    if hasValidEntry then
        player:setLocalVar('INSTANCE_ID', instanceId)
        player:startEvent(unpack(instanceTriggerArgs))

        return true
    else
        return false
    end
end

xi.instance.onEventUpdate = function(player, csid, option, npc)
    local instanceId = player:getLocalVar('INSTANCE_ID')
    local party      = player:getParty()
    local ID         = zones[player:getZoneID()]

    if party ~= nil then
        for _, v in pairs(party) do
            if
                v:getID() ~= player:getID() and
                v:getZoneID() == player:getZoneID()
            then
                -- Check entry requirements for party
                if not checkEntryReqs(v, instanceId) then
                    player:messageText(npc, ID.text.MEMBER_NO_REQS, false)
                    player:instanceEntry(npc, 1)

                    return false
                end

                -- Check everyone is in range
                if v:checkDistance(player) > 50 then
                    player:messageText(npc, ID.text.MEMBER_TOO_FAR, false)
                    player:instanceEntry(npc, 1)

                    return false
                end
            end
        end
    end

    if player:getLocalVar('INSTANCE_REQUESTED') == 0 then
        player:createInstance(instanceId)
        player:setLocalVar('INSTANCE_REQUESTED', 1)
    end

    if
        player:getInstance() ~= nil or
        (player:getLocalVar('INSTANCE_REQUESTED') > 0 and
        player:getLocalVar('INSTANCE_REQUESTED') < 10)
    then
        -- return true so we don't immediately call the cancel event update (since instances don't immediately load), but
        -- increment variable to eventually return false if instance fails to load and trigger onInstanceCreatedCallback
        player:setLocalVar('INSTANCE_REQUESTED', player:getLocalVar('INSTANCE_REQUESTED') + 1)
        return true
    else
        return false
    end
end

-- 'Default' behavior. It's up to each instance whether or not they want to use this logic
xi.instance.onInstanceCreatedCallback = function(player, instance)
    local zoneLookup = xi.instance.lookup[instance:getZone():getID()]
    local instanceId = instance:getID()

    -- Collect cs for party members
    local lookupEntry
    for _, entry in ipairs(zoneLookup) do
        local entryInstanceId = entry[1]
        if instanceId == entryInstanceId then
            lookupEntry = entry

            break
        end
    end

    -- If you're in the official entrance zone, try and playout the
    -- entrance animation. Otherwise: go straight to the instance
    if player:getZoneID() == instance:getEntranceZoneID() then
        -- join initiating player as commander
        player:setInstance(instance)

        -- This packet will trigger the end of the blocking
        -- cutscene and xi.instance.onEventFinish will handle
        -- the transportation
        for _, v in ipairs(player:getParty()) do
            if v:getZoneID() == player:getZoneID() then
                if v:getID() ~= player:getID() then
                    -- player will be brought into instance either way
                    -- this makes the animation trigger reliably
                    v:release()
                    v:startEvent(unpack(lookupEntry[4]))

                    v:setInstance(instance)
                    local npc = player:getEventTarget()
                    if npc ~= nil then
                        v:instanceEntry(npc, 4)
                    end
                end

                v:timer(35000, function(playerArg)
                    -- failsafe to bring all players into instance
                    -- if a player doesn't receive the event packet, the whole party will be stuck in blackscreen
                    -- timer is destroyed if onEventFinish works properly and player gets zoned
                    -- a properly-functioning event loop will take 20s to zoning into the instance
                    -- this _should_ be completely unnecessary due to the looping logic with INSTANCE_REQUESTED, but just in case
                    local instanceArg = playerArg:getInstance()
                    if instanceArg then
                        print(fmt('Player {} failed to cleanly transition into instance event, forcing entry via setPos.', playerArg:getName()))
                        playerArg:setPos(0, 0, 0, 0, instanceArg:getZone():getID())
                    end
                end)
            end
        end

        -- finally, send commander in
        player:startEvent(unpack(lookupEntry[4])) -- will fail if previous event is working as it should, otherwise catches secondary event to enter
        local npc = player:getEventTarget()
        if npc ~= nil then
            player:instanceEntry(npc, 4)
        end
    else
        for _, v in ipairs(player:getParty()) do
            v:setInstance(instance)
            v:setPos(0, 0, 0, 0, instance:getZone():getID())
        end
    end
end

xi.instance.onEventFinish = function(player, csid, option, npc)
    local instance = player:getInstance()

    if instance then
        local instanceZoneId         = instance:getZone():getID()
        local zoneLookup             = xi.instance.lookup[instanceZoneId]
        local csidEntry, optionEntry = unpack(zoneLookup[1][3])

        if csid == csidEntry and option == optionEntry then
            for _, v in ipairs(player:getParty()) do
                v:setPos(0, 0, 0, 0, instance:getZone():getID())
            end

            return true
        end
    end

    return false
end

local function setInstanceLastTimeUpdateMessage(instance, players, remainingTimeLimit, text)
    local message        = 0
    local lastTimeUpdate = instance:getLastTimeUpdate()

    if lastTimeUpdate == 0 and remainingTimeLimit < 600 then
        message = 600
    elseif lastTimeUpdate == 600 and remainingTimeLimit < 300 then
        message = 300
    elseif lastTimeUpdate == 300 and remainingTimeLimit < 60 then
        message = 60
    elseif lastTimeUpdate == 60 and remainingTimeLimit < 30 then
        message = 30
    elseif lastTimeUpdate == 30 and remainingTimeLimit < 10 then
        message = 10
    end

    if message ~= 0 then
        for i, player in pairs(players) do
            if remainingTimeLimit >= 60 then
                player:messageSpecial(text.TIME_REMAINING_MINUTES, message / 60)
            else
                player:messageSpecial(text.TIME_REMAINING_SECONDS, message)
            end
        end

        instance:setLastTimeUpdate(message)
    end
end

xi.instance.updateInstanceTime = function(instance, elapsed, text)
    local players            = instance:getChars()
    local remainingTimeLimit = instance:getTimeLimit() * 60 - (elapsed / 1000)
    local wipeTime           = instance:getWipeTime()

    if
        remainingTimeLimit < 0 or
        (wipeTime ~= 0 and (elapsed - wipeTime) / 1000 > 180
        )
    then
        instance:fail()

        return
    end

    if wipeTime == 0 then
        local wipe = true

        for i, player in pairs(players) do
            if player:getHP() ~= 0 then
                wipe = false
                break
            end
        end

        if wipe then
            for i, player in pairs(players) do
                player:messageSpecial(text.PARTY_FALLEN, 3)
            end

            instance:setWipeTime(elapsed)
        end
    else
        for i, player in pairs(players) do
            if player:getHP() ~= 0 then
                instance:setWipeTime(0)
                break
            end
        end
    end

    setInstanceLastTimeUpdateMessage(instance, players, remainingTimeLimit, text)
end
