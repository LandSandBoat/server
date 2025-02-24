-----------------------------------
-- custom_quest
-----------------------------------
require("modules/module_utils")
require("scripts/globals/npc_util")
require("scripts/mixins/job_special")
-----------------------------------
local m = Module:new("custom_quest")

local settings =
{
    -- Respawn of spawners
    RESPAWN = 180000, -- 3 minutes
}

m.marker =
{
    SPARKLE  = 1382,
    BLUE     = 2424,
    FRAGMENT = 2356,
    SHIMMER  = 2326,
}

m.MAIN_QUEST   = "MAIN_QUEST"
m.SIDE_QUEST   = "SIDE_QUEST"
m.NOTHING      = { "You see nothing out of the ordinary." }
m.NOTHING_ELSE = { "There is nothing else to do here." }

m.standardImmunities =
{
    xi.immunity.DARK_SLEEP,
    xi.immunity.GRAVITY,
    xi.immunity.LIGHT_SLEEP,
    xi.immunity.PETRIFY,
    xi.immunity.SILENCE,
}

m.newMission = function(player, missionName)
    text = "\129\158 New Mission: %s"
    player:printToPlayer(string.format(text, missionName), xi.msg.channel.SYSTEM_3)
end

m.questAccepted = function(player, questName, isMission)
    local text = "\129\158 Quest Accepted: %s"

    if isMission then
        text = "\129\158 Mission Accepted: %s"
    end

    player:printToPlayer(string.format(text, questName), xi.msg.channel.SYSTEM_3)
end

m.questCompleted = function(player, questName, music, isMission)
    local text = "\129\159 Quest Completed: %s"

    if isMission then
        text = "\129\159 Mission Completed: %s"
    end

    player:printToPlayer(string.format("\129\159 Quest Completed: %s", questName), xi.msg.channel.SYSTEM_3)

    player:changeMusic(0, 67)
    player:changeMusic(1, 67)
    player:timer(5000, function(playerArg)
        player:changeMusic(0, music or 0)
        player:changeMusic(1, music or 0)
    end)
end

m.spawnerOptions = function()
    return {
        {
            "Not yet",
        },
        {
            "I'm ready",
            true,
        },
    }
end

local rollAugments = function(augments)
    local result = {}

    for k, v in pairs(augments) do
        local field = v

        if type(v) == "table" then
            field = math.random(v[1], v[2])
        end

        table.insert(result, field)
    end

    return result
end

local tierAugments = function(tiers)
    local result = math.random(0, 100)

    if result < 10 then
        return tiers[3]
    elseif result < 25 then
        return tiers[2]
    else
        return tiers[1]
    end
end

local function getTradedItem(trade, itemID)
    for i = 0, trade:getSlotCount()-1 do
        local item = trade:getItemId(i)

        if trade:getItemId(i) == itemID then
            return trade:getItem(i)
        end
    end
end

m.transferAugments = function(player, trade, sourceID, destID)
    local ID   = zones[player:getZoneID()]
    local item = getTradedItem(trade, sourceID)

    if player:getFreeSlotsCount() > 0 then
        local aug0 = item:getAugment(0)
        local aug1 = item:getAugment(1)
        local aug2 = item:getAugment(2)
        local aug3 = item:getAugment(3)

        player:tradeComplete()

        player:addItem(destID, 1, aug0[1], aug0[2], aug1[1], aug1[2], aug2[1], aug2[2], aug3[1], aug3[2])

        player:timer(1000, function()
            player:messageSpecial(ID.text.ITEM_OBTAINED, destID)
        end)
    end
    
    -- Don't consume trade if the item wasn't added above
    -- player:tradeComplete()
end

m.giveAugmentRoll = function(player, item, augs)
    local ID = zones[player:getZoneID()]

    if player:getFreeSlotsCount() > 0 then
        local rolling = augs

        -- If passed a table of tables, assume tiered
        if type(augs[1]) == "table" then
            rolling = tierAugments(augs)
        end

        local rolls = rollAugments(rolling)

        player:addItem(item, 1, unpack(rolls))
        player:messageSpecial(ID.text.ITEM_OBTAINED, item)

        return true
    else
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        return false
    end
end

m.jobReward = function(rewards, questVar, resetStep)
    return function(player, npc, tbl)
        local job      = player:getMainJob()
        local varName  = string.format("%s_%s",       questVar, xi.jobNames[job][1])
        local midnight = string.format("%s_MIDNIGHT", questVar)
        local received = player:getCharVar(varName)

        npc:entityAnimationPacket("open")
        npc:timer(5000, function(npcArg)
            npcArg:entityAnimationPacket("close")
        end)

        -- Skip jobs that don't have rewards
        if rewards[job] ~= nil then
            local receivedJobRewards = false

            -- Check each item in the reward list for the player's current job
            for k, v in pairs(rewards[job]) do
                -- Check player has not already received this item for this job
                if not utils.mask.getBit(received, k) then
                    if npcUtil.giveItem(player, v) then
                        -- Make sure the player can't receive this item again for this job
                        local result = utils.mask.setBit(received, k, true)
                        player:setCharVar(varName, result)

                        -- Ensure this variable is up to date
                        received = player:getCharVar(varName)
                        receivedJobRewards = true
                    else
                        -- Unable to distribute item (Inventory full etc.)
                         -- Return false to allow re-attempt (Or continuation to receive remaining rewards)
                        return false
                    end
                end
            end

            if receivedJobRewards then
                player:printToPlayer(string.format("You received the job rewards for %s!", xi.jobNames[job][2]))
            end
        end

        -- Give default reward to everyone
        if
            rewards[0] ~= nil and
            not npcUtil.giveItem(player, rewards[0])
        then
            -- Unable to distribute item (Inventory full etc.)
            return false
        end

        -- Prevent more rewards before tomorrow
        player:setCharVar(midnight, getMidnight())

        -- Reset quest to this step
        player:setCharVar(questVar, resetStep)
    end
end

m.tradeWeekly = function(rewards, questVar, success, decline)
    return function(player, npc, trade, entity, var, step)
        local week = rewards[VanadielRSERace()]

        if npcUtil.tradeHasExactly(trade, week.required) then
            local delay  = cexi.util.dialogDelay(entity.dialog[success])
            local result = week.rewards[math.random(1, #week.rewards)]

            -- Delay rewards until after success dialog
            npc:timer(delay, function(npgArg)
                if m.giveAugmentRoll(player, result.item, result.augs) then
                    player:setCharVar(questVar, cexi.util.nextVanaWeek())
                    player:tradeComplete()
                end
            end)

            cexi.util.dialog(player, entity.dialog[success], entity.name, { npc = npc })
        else
            player:tradeRelease()
            cexi.util.dialog(player, entity.dialog[decline], entity.name, { [1] = week.name, npc = npc })
        end
    end
end

m.talkWeekly = function(rewards, text)
    return function(player, npc, entity)
        local week = rewards[VanadielRSERace()]
        cexi.util.dialog(player, entity.dialog[text], entity.name, { [1] = week.name, npc = npc })
    end
end

local function getEntity(player, entityName)
    local zone     = player:getZone()
    local deEntity = string.gsub(entityName, "_", " ")
    local result   = zone:queryEntitiesByName("DE_" .. deEntity)
    return result[1]
end

local function getEntities(player, entityName)
    local zone     = player:getZone()
    local deEntity = string.gsub(entityName, "_", " ")
    local result   = zone:queryEntitiesByName("DE_" .. deEntity)
    return result
end

local function getEntityInfo(entities, entityID)
    local entityInfo = nil

    for k, v in pairs(entities) do
        if v.id == entityID then
            entityInfo = v
        end
    end

    if entityInfo == nil then
        print(string.format("[CE] Unable to match mob %s with quest entities", entityID))
    end

    return entityInfo
end

local function entityFromID(player, entities, entityID)
    local entityInfo = getEntityInfo(entities, entityID)
    return getEntity(player, entityInfo.name)
end

local function hideNPC(npc)
    npc:setStatus(xi.status.INVISIBLE)

    npc:timer(settings.RESPAWN, function(npcArg)
        npcArg:setStatus(xi.status.NORMAL)
    end)
end

local function dialogFrom(tbl)
    if tbl.dialog and not tbl.dialog.NAME then
        return ""
    elseif tbl.from then
        return tbl.from
    else
        return tbl.name
    end
end

local function getStepFunctions(steps, id)
    local func = {}

    for i = 1, #steps do
        if steps[i][id] ~= nil then
            func[i] = steps[i][id]
        end
    end

    return func
end

local function hasTasksRemaining(player, tasklist)
    for _, task in pairs(tasklist) do
        if type(task[1]) == "table" then
            for _, subtask in pairs(task[1]) do
                if player:getCharVar(subtask) < task[2] then
                    return true
                end
            end
        else
            if player:getCharVar(task[1]) < task[2] then
                return true
            end
        end
    end

    return false
end

m.task = function(obj)
    return function(player, npc, tbl, var, step)
        if hasTasksRemaining(player, obj.tasklist) then
            local msg   = {}
            local delay = 0

            for _, line in pairs(obj.reminder) do
                table.insert(msg, line)
            end

            for _, task in pairs(obj.tasklist) do
                if type(task[1]) == "table" then
                    local prog = 0

                    for _, subtask in pairs(task[1]) do
                        local status = player:getCharVar(subtask)

                        if status >= task[2] then
                            prog = prog + 1
                        end
                    end

                    table.insert(msg, string.format(" %s (%u/%u)", task[3], prog, #task[1]))
                else
                    local prog = player:getCharVar(task[1])
                    table.insert(msg, string.format(" %s (%u/%u)", task[3], prog, task[2]))
                end
            end

            if obj.wrapper ~= nil then
                msg = obj.wrapper(msg)
            end

            cexi.util.dialog(player, msg, obj.name, { npc = npc })
        else
            if player:getLocalVar("[CU]BLOCKING") == 1 then
                return
            end

            cexi.util.dialog(player, obj.accepted, obj.name, { npc = npc })

            if
                obj.step == nil or
                obj.step
            then
                player:setLocalVar("[CU]BLOCKING", 1)

                local delay = cexi.util.dialogDelay(obj.accepted)

                player:timer(delay, function(playerArg)
                    if obj.reward == nil then
                        playerArg:setCharVar(var, step)
                    else
                        if npcUtil.giveItem(playerArg, obj.reward) then
                            playerArg:setCharVar(var, step)
                        end
                    end

                    playerArg:setLocalVar("[CU]BLOCKING", 0)
                end)
            end
        end
    end
end

m.talkStep = function(text, questName, isMission)
    return function(player, npc, tbl, var, step)
        cexi.util.dialog(player, tbl.dialog[text], dialogFrom(tbl), { npc = npc })

        local delay = cexi.util.dialogDelay(tbl.dialog[text])
        player:timer(delay, function(playerArg)
            player:setCharVar(var, step)

            if questName ~= nil then
                m.questAccepted(player, questName, isMission)
            end
        end)
    end
end

m.markStep = function(locs, text, func)
    return function(player, npc, tbl, var, step)
        if player:getLocalVar("[CU]BLOCKING") == 1 then
            return
        end

        player:setLocalVar("[CU]BLOCKING", 1)

        local anim =
        {
            { animation = 48, target = "player", duration = 3000 },
        }

        if text ~= nil then
            anim = text
        end

        cexi.util.dialog(player, anim, dialogFrom(tbl), { npc = npc })

        local delay = cexi.util.dialogDelay(anim)

        player:timer(delay, function(playerArg)
            npc:setStatus(xi.status.INVISIBLE)
            local next = locs[math.random(1, #locs)]
            npc:setPos(unpack(next))

            npc:timer(5000, function(npcArg)
                npcArg:setStatus(xi.status.NORMAL)
            end)

            player:setLocalVar("[CU]BLOCKING", 0)
            player:setCharVar(var, step)
            func(player, step - 1)
        end)
    end
end

local conditional =
{
    ["job"] = function(player, tbl)
        return tbl[player:getMainJob()]
    end,
}

m.dialog = function(obj)
    return function(player, npc, tbl, var, step)
        if
            obj.check ~= nil and
            not m.checks(obj.check)
        then
            cexi.util.dialog(player, tbl.dialog.DEFAULT, obj.name, { npc = npc })
            return
        end

        local event = obj.event

        if obj.conditionalDialog ~= nil then
            event = conditional[obj.conditionalDialog](player, obj.event)
        end

        cexi.util.dialog(player, event, obj.name, { npc = npc })

        if
            obj.step == nil or
            obj.step
        then
            local delay = cexi.util.dialogDelay(event)
            player:setLocalVar("[CU]REWARD", 1)

            player:timer(delay, function(playerArg)
                if obj.reward == nil then
                    player:setCharVar(var, step)

                    if obj.quest ~= nil then
                        m.questAccepted(player, obj.quest, false)
                    elseif obj.mission ~= nil then
                        m.newMission(player, obj.mission)
                    end
                else
                    local reward = obj.reward

                    if obj.conditionalReward ~= nil then
                        reward = conditional[obj.conditionalReward](player, obj.reward)
                    end

                    if type(reward) == "number" then
                        if npcUtil.giveItem(player, reward) then
                            if
                                obj.step == nil or
                                obj.step
                            then
                                player:setCharVar(var, step)

                                if obj.beginQuest ~= nil then
                                    m.questAccepted(player, obj.beginQuest)
                                elseif obj.quest ~= nil then
                                    m.questCompleted(player, obj.quest, obj.music, false)
                                elseif obj.mission ~= nil then
                                    m.newMission(player, obj.mission)
                                end
                            end
                        else
                            player:setLocalVar("[CU]REWARD", 0)
                            return false
                        end
                    else
                        if reward.exp ~= nil then
                            player:addExp(reward.exp)
                            player:setCharVar(var, step)
                        end

                        if reward.allied_notes ~= nil then
                            player:addCurrency("allied_notes", reward.allied_notes)
                            player:setCharVar(var, step)

                            if obj.quest ~= nil then
                                m.questCompleted(player, obj.quest, obj.music, false)
                            elseif obj.mission ~= nil then
                                m.newMission(player, obj.mission)
                            end
                        end

                        if type(reward[1]) == "table" then
                            if npcUtil.giveItem(player, reward) then
                                if
                                    obj.step == nil or
                                    obj.step
                                then
                                    player:setCharVar(var, step)

                                    if obj.quest ~= nil then
                                        m.questCompleted(player, obj.quest, obj.music, false)
                                    elseif obj.mission ~= nil then
                                        m.newMission(player, obj.mission)
                                    end
                                end
                            else
                                player:setLocalVar("[CU]REWARD", 0)
                                return false
                            end
                        end
                    end
                end

                if obj.after ~= nil then
                    obj.after(player)
                end

                player:setLocalVar("[CU]REWARD", 0)
            end)
        end
    end
end

local function delaySendMenu(player, menu)
    player:timer(300, function(playerArg)
        playerArg:customMenu(menu)
    end)
end

m.purchaseItem = function(player, npc, item, obj)
    local balance  = player:getCharVar(obj.var)

    if item[3] > balance then
        player:sys("You can't afford this purchase.")
        return
    end

    delaySendMenu(player, {
        title   = fmt("Buy {} ({})?", item[1], item[3]),
        options =
        {
            {
                "No",
                function()
                end,
            },
            {
                "Yes",
                function()
                    if type(item[2]) == "string" then
                        player:setCharVar(item[2], 1)
                        player:sys(item[4])
                        player:incrementCharVar(obj.var, -item[3])
                    else
                        if npcUtil.giveItem(player, item[2]) then
                            npc:facePlayer(player, true)
                            player:incrementCharVar(obj.var, -item[3])
                        end
                    end
                end,
            },
        },
    })
end

m.shop = function(obj)
    return function(player, npc, tbl, var, step)
        local balance  = player:getCharVar(obj.var)
        local purchase = function(player, npc, item)
            m.purchaseItem(player, npc, item, obj)
        end

        if obj.dialog ~= nil then
            cexi.util.dialog(player, obj.dialog, "", { npc = npc })
        end

        local list = {}

        for _, item in pairs(obj.list) do
            if type(item[2]) == "string" then
                if player:getCharVar(item[2]) == 0 then
                    table.insert(list, item)
                end
            else
                table.insert(list, item)
            end
        end

        cexi.util.simpleShop(player, npc, list, purchase, fmt(obj.title, balance))
    end
end

m.npcSpawner = function(tbl, npc, spawner, keepSpawner)
    local result = {}
    local before = {}
    local after  = {}

    local npcs = npc

    if type(npc) ~= "table" then
        npcs = { npc }
    end

    if keepSpawner then
        before =
        {
            { noturn  = true },
            { spawn   = npcs },
            { delay   = 500 },
            { entity  = npcs[1], face = "player" },
            { delay   = 500 },
        }

        after =
        {
            { delay   = 500 },
            { despawn = npcs },
        }
    else
        before =
        {
            { despawn = { spawner } },
            { spawn   = npcs },
            { delay   = 500 },
            { entity  = npcs[1], face = "player" },
            { delay   = 500 },
        }

        after =
        {
            { delay   = 500 },
            { despawn = npcs },
            { spawn   = { spawner } },
        }
    end

    for _, line in pairs(before) do
        table.insert(result, line)
    end

    for _, line in pairs(tbl) do
        table.insert(result, line)
    end

    for _, line in pairs(after) do
        table.insert(result, line)
    end

    return result
end


m.checkStep = function(text, alternative, name, check)
    return function(player, npc, tbl, var, step)
        if (m.checks(check))(player) then
            cexi.util.dialog(player, tbl.dialog[text], dialogFrom(tbl), { npc = npc })

            local delay = cexi.util.dialogDelay(tbl.dialog[text])
            player:timer(delay, function(playerArg)
                player:setCharVar(var, step)

                if questName ~= nil then
                    m.questAccepted(player, questName)
                end
            end)
        else
            cexi.util.dialog(player, tbl.dialog[alternative], dialogFrom(tbl), { npc = npc })
        end
    end
end

m.teleOnly = function(menuInfo, telePos)
    return function(player, npc, tbl)
        player:customMenu({
            title   = menuInfo[1],
            options =
            {
                {
                    menuInfo[2],
                    function()
                    end,
                },

                {
                    menuInfo[3],
                    function()
                        player:injectActionPacket(player:getID(), 6, 600, 0, 0, 0, 0, 0)

                        player:timer(1250, function(playerArg)
                            playerArg:setPos(unpack(telePos))
                        end)
                    end,
                },
            },
        })
    end
end

m.talkFinish = function(text, questName, music, isMission)
    return function(player, npc, tbl, var, step)
        cexi.util.dialog(player, tbl.dialog[text], dialogFrom(tbl), { npc = npc })

        local delay = cexi.util.dialogDelay(tbl.dialog[text])
        player:timer(delay, function(playerArg)
            player:setCharVar(var, step)

            if questName ~= nil then
                m.questCompleted(player, questName, music, isMission)
            end
        end)
    end
end

m.talkOnly = function(text)
    return function(player, npc, tbl)
        cexi.util.dialog(player, tbl.dialog[text], dialogFrom(tbl), { npc = npc })
    end
end

m.talkString = function(text)
    return function(player, npc, tbl)
        cexi.util.dialog(player, { text }, nil)
    end
end

m.talkTally = function(text, varName)
    return function(player, npc, tbl)
        cexi.util.dialog(player, tbl.dialog[text], dialogFrom(tbl), { [1] = player:getCharVar(varName) + 1, npc = npc })
    end
end

m.spawnAdd = function(source, target, name, cap, mobPos, mobLevel, mobHP)
    local zone   = source:getZone()
    local result = zone:queryEntitiesByName("DE_" .. name)

    for _, mob in pairs(result) do
        if mob ~= nil and not mob:isAlive() then
            local pos = {}

            if mobPos == nil then
                pos = source:getPos()
                pos.x = pos.x + math.random(-2, 2)
                pos.z = pos.z + math.random(-2, 2)
            else
                pos =
                {
                    x   = mobPos[1],
                    y   = mobPos[2],
                    z   = mobPos[3],
                    rot = mobPos[4],
                }
            end

            mob:setSpawn(pos.x, pos.y, pos.z, pos.rot)
            mob:setDropID(0)

            mob:spawn()

            if mobLevel ~= nil then
                mob:setMobLevel(mobLevel)
            end

            mob:updateClaim(target)
            mob:setLocalVar("NO_CASKET", 1)

            mob:setRespawnTime(0)
            DisallowRespawn(mob:getID(), true)

            mob:setHP(mob:getMaxHP())
            mob:updateHealth()

            if mobHP ~= nil then
                local hp  = mob:getMaxHP()
                local hpp = math.ceil((mobHP / hp) * 100) - 100
                mob:addMod(xi.mod.HPP, hpp)
                mob:updateHealth()
                mob:setHP(mob:getMaxHP())
            end

            mob:addImmunity(xi.immunity.GRAVITY)
            mob:addImmunity(xi.immunity.BIND)
            mob:addImmunity(xi.immunity.SILENCE)
            mob:addImmunity(xi.immunity.LIGHT_SLEEP)
            mob:addImmunity(xi.immunity.DARK_SLEEP)
            mob:addImmunity(xi.immunity.PETRIFY)

            if cap ~= nil then
                local flags = xi.effectFlag.DEATH + xi.effectFlag.ON_ZONE + xi.effectFlag.CONFRONTATION

                if raiseAllowed ~= nil then
                    flags = xi.effectFlag.ON_ZONE + xi.effectFlag.CONFRONTATION
                end

                mob:addStatusEffectEx(
                    xi.effect.LEVEL_RESTRICTION,
                    xi.effect.LEVEL_RESTRICTION,
                    cap or 75,
                    0,
                    0,
                    0,
                    0,
                    0,
                    flags
                )
            end
        end
    end
end

m.spawnWave = function(tbl)
    if tbl.target == nil then
        return
    end

    for index, wave in pairs(tbl.waves) do
        if
            tbl.parent:getHPP() <= wave.hp and
            tbl.parent:getLocalVar("MOBS_SUMMONED") < index
        then
            tbl.parent:setLocalVar("MOBS_SUMMONED", index)

            for _, waveMob in pairs(wave.mobs) do
                m.spawnAdd(tbl.parent, tbl.target, waveMob.name, tbl.cap, waveMob.pos, waveMob.level, waveMob.hp, tbl.raiseAllowed)
            end

            if tbl.target:isPC() then
                tbl.target:printToArea("summons reinforcements!", xi.msg.channel.EMOTION, xi.msg.area.SAY, tbl.parent:getPacketName())
            end
        end
    end
end

m.abilityAt = function(tbl)
    if tbl.target == nil then
        return
    end

    for index, action in pairs(tbl.list) do
        if
            tbl.mob:getHPP() <= action.hp and
            tbl.mob:getLocalVar("ABILITY_USED") < index
        then
            tbl.mob:setLocalVar("ABILITY_USED", index)
            tbl.mob:useMobAbility(action.ability)
        end
    end
end

local matchT2 = -- [element id][resonance id]
{
--    1  2  3  4  5  6  7  8  9  10 11 12 13
--    N  T  C  L  S  R  D  I  I  G  D  F  F
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, -- (1) NONE
    { 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0 }, -- (2) FIRE
    { 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0 }, -- (3) ICE
    { 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1 }, -- (4) WIND
    { 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0 }, -- (5) EARTH
    { 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1 }, -- (6) THUNDER
    { 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0 }, -- (7) WATER
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 }, -- (8) LIGHT
    { 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 }, -- (9) DARK
}

local matchT3 = -- [element id][resonance id]
{
--    1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17
--    N  T  C  L  S  R  D  I  I  G  D  F  F  L  D  L  D
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, -- (1) NONE
    { 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0 }, -- (2) FIRE
    { 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1 }, -- (3) ICE
    { 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0 }, -- (4) WIND
    { 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1 }, -- (5) EARTH
    { 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0 }, -- (6) THUNDER
    { 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1 }, -- (7) WATER
    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0 }, -- (8) LIGHT
    { 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1 }, -- (9) DARK
}

local function matchResonance(ele, resonance, tier)
    if tier == 2 then
        local isMatch = matchT2[ele + 1][resonance:getPower() + 1]
        return (isMatch ~= nil and isMatch > 0)
    else
        local isMatch = matchT3[ele + 1][resonance:getPower() + 1]
        return (isMatch ~= nil and isMatch > 0)
    end
end

m.mbCounter = function(mob, element, delay, limit, tier)
    mob:addListener('MAGIC_TAKE', 'MB_COUNTER', function(target, caster, spell)
        local timeNow    = os.time()
        local nextWindow = mob:getLocalVar("nextWindow")

        if timeNow < nextWindow then
            return
        end

        local magicBurstCounter = mob:getLocalVar("magicBurstCounter")

        if spell:tookEffect() and (caster:isPC() or caster:isPet()) and spell:getElement() == element then
            local resonance = target:getStatusEffect(xi.effect.SKILLCHAIN)

            if
                resonance ~= nil and
                resonance:getTier() > 0 and
                matchResonance(element, resonance, tier)
            then
                mob:setLocalVar("magicBurstCounter", magicBurstCounter + 1)
                mob:setLocalVar("nextWindow", timeNow + delay)
            end
        end
    end)
end

m.mbWeaken = function(mob, limit, lowerStat)
    local weaknessCounter = mob:getLocalVar("weaknessCounter")

    if weaknessCounter >= limit then
        mob:removeListener("MB_COUNTER")
        return
    end

    local magicBurstCounter = mob:getLocalVar("magicBurstCounter")

    if weaknessCounter < magicBurstCounter then
        mob:setLocalVar("weaknessCounter", weaknessCounter + 1)

        mob:timer(1000, function()
            if weaknessCounter < 5 then
                mob:weaknessTrigger(1)
            elseif weaknessCounter < 10 then
                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 3)
                mob:weaknessTrigger(2)
            else
                mob:addStatusEffect(xi.effect.TERROR, 0, 0, 5)
                mob:weaknessTrigger(3)
            end
        end)

        for statName, statAmount in pairs(lowerStat) do
            local current = mob:getMod(statName)
            mob:setMod(statName, current + statAmount)
        end
    end
end

local function setEncounter(entity, params)
    local flags = xi.effectFlag.DEATH + xi.effectFlag.ON_ZONE

    if params.raiseAllowed ~= nil then
        flags = xi.effectFlag.ON_ZONE
    end

    entity:addStatusEffectEx(
        xi.effect.LEVEL_RESTRICTION,
        xi.effect.LEVEL_RESTRICTION,
        params.levelCap,
        0,
        0,
        0,
        0,
        0,
        flags + xi.effectFlag.CONFRONTATION
    )

    if params.subjob ~= nil and params.subjob == false then
        entity:addStatusEffectEx(
            xi.effect.SJ_RESTRICTION,
            xi.effect.SJ_RESTRICTION,
            0,
            0,
            0,
            0,
            0,
            0,
            flags
        )
    end
end

local function applyLevelCap(player, params)
    if
        params ~= nil and
        params.levelCap ~= nil
    then
        local zoneID   = player:getZoneID()
        local alliance = player:getAlliance()

        for i = 1, #alliance do
            if alliance[i]:getZoneID() == zoneID then
                setEncounter(alliance[i], params)

                local pet = alliance[i]:getPet()

                if pet ~= nil then
                    setEncounter(pet, params)
                end
            end
        end
    end
end

local levelCaps =
{
    16, -- Promyvion - Holla
    18, -- Promyvion - Dem
    20, -- Promyvion - Mea
    22, -- Promyvion-Vahzl
    28, -- Sacrarium
    29, -- Riverne Site B01
    30, -- Riverne Site A01
}

local function isLevelCappedZone(zoneID)
    for k, v in pairs(levelCaps) do
        if v == zoneID then
            return true
        end
    end

    return false
end

local function removeLevelCap(player)
    local zoneID   = player:getZoneID()

    if isLevelCappedZone(zoneID) then
        return
    end

    local alliance = player:getAlliance()

    for i = 1, #alliance do
        if alliance[i]:getZoneID() == zoneID then
            alliance[i]:delStatusEffect(xi.effect.LEVEL_RESTRICTION)

            local pet = alliance[i]:getPet()

            if pet ~= nil then
                pet:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            end
        end
    end
end

local function resetAllStep(player, var, step, setStep, check, params)
    if player ~= nil then
        local zoneID   = player:getZoneID()
        local alliance = player:getAlliance()

        for i = 1, #alliance do
            if
                alliance[i]:isPC() and 
                alliance[i]:getZoneID() == zoneID and
                alliance[i]:getCharVar(var) == step
            then
                if
                    check == nil or
                    check(alliance[i])
                then
                    if
                        params ~= nil and
                        params.flag ~= nil
                    then
                        if alliance[i]:getLocalVar(params.flag) == 1 then
                            alliance[i]:setCharVar(var, setStep)
                            alliance[i]:setLocalVar(params.flag, 0)
                        end
                    else
                        alliance[i]:setCharVar(var, setStep)
                    end
                end
            end
        end
    end
end

local function incrementAllStep(player, var, step, check, params)
    if player ~= nil then
        local zoneID   = player:getZoneID()
        local alliance = player:getAlliance()

        for i = 1, #alliance do
            if
                alliance[i]:isPC() and 
                alliance[i]:getZoneID() == zoneID and
                alliance[i]:getCharVar(var) == step
            then
                if
                    params ~= nil and
                    params.flag ~= nil
                then
                    if alliance[i]:getLocalVar(params.flag) == 1 then
                        alliance[i]:incrementCharVar(var, 1)
                        alliance[i]:setLocalVar(params.flag, 0)
                    end
                else
                    alliance[i]:incrementCharVar(var, 1)
                end
            end
        end
    end
end

local function setAllVar(player, var, val, expiry)
    if player ~= nil then
        local zoneID   = player:getZoneID()
        local alliance = player:getAlliance()

        for i = 1, #alliance do
            if
                alliance[i] ~= nil and
                alliance[i]:isPC() and 
                alliance[i]:getZoneID() == zoneID
            then
                -- Prevent resetting cooldown again
                if alliance[i]:getCharVar(var) == 0 then
                    alliance[i]:setCharVar(var, val, expiry)
                end
            end
        end
    end
end

local function setAllLocalVar(player, var, val)
    if player ~= nil then
        local zoneID   = player:getZoneID()
        local alliance = player:getAlliance()

        for i = 1, #alliance do
            if
                alliance[i] ~= nil and
                alliance[i]:isPC() and 
                alliance[i]:getZoneID() == zoneID
            then
                alliance[i]:setLocalVar(var, val)
            end
        end
    end
end

local function sayAll(player, str, channel)
    if player ~= nil then
        local zoneID   = player:getZoneID()
        local alliance = player:getAlliance()

        for i = 1, #alliance do
            if
                alliance[i]:isPC() and 
                alliance[i]:getZoneID() == zoneID
            then
                alliance[i]:printToPlayer(str, channel or xi.msg.channel.NS_SAY)
            end
        end
    end
end

local function spawnMobID(player, npc, entities, entityID, params)
    local mobInfo = getEntityInfo(entities, entityID)
    local zone    = player:getZone()
    local result  = zone:queryEntitiesByName("DE_" .. mobInfo.name)

    for k, v in pairs(result) do
        if v ~= nil and not v:isAlive() then
            if
                params ~= nil and
                params.setPos ~= nil
            then
                v:setSpawn(params.setPos.x, params.setPos.y, params.setPos.z, params.setPos.rotation)
            else
                v:setSpawn(mobInfo.pos[1], mobInfo.pos[2], mobInfo.pos[3], mobInfo.pos[4])
            end

            if mobInfo.dropID then
                v:setDropID(mobInfo.dropID)
            else
                v:setDropID(0)
            end

            local spawnLevel = mobInfo.level

            if
                params ~= nil and
                params.scaleVar ~= nil
            then
                local scaling = player:getCharVar(params.scaleVar)
                spawnLevel    = spawnLevel + scaling
            end

            v:spawn()
            v:setMobLevel(spawnLevel)
            v:updateClaim(player)
            v:setLocalVar("NO_CASKET", 1)


            -- Apply enmity to party to prevent despawn on spawner death
            local alliance = player:getAlliance()

            if
                alliance ~= nil and
                #alliance > 1
            then
                for _, member in pairs(alliance) do
                    v:addEnmity(member, 1, 0)
                end
            end

            -- Quest mobs should not respawn
            v:setRespawnTime(0)
            DisallowRespawn(v:getID(), true)

            if mobInfo.mods ~= nil then
                for mod, value in pairs(mobInfo.mods) do
                    v:setMod(mod, value)
                end
            end

            if mobInfo.effects ~= nil then
                for effectID, effectTable in pairs(mobInfo.effects) do
                    v:addStatusEffect(effectID, unpack(effectTable))
                end
            end

            v:setHP(v:getMaxHP())
            v:updateHealth()

            if mobInfo.hp ~= nil then
                local mobHP = v:getMaxHP()
                local hpp   = math.max(math.ceil((mobInfo.hp / mobHP) * 100) - 100, 0)
                v:addMod(xi.mod.HPP, hpp)
                v:updateHealth()
                v:setHP(v:getMaxHP())
            end

            if params ~= nil then
                if params.levelCap ~= nil then
                    v:setMobMod(xi.mobMod.DRAW_IN, 15) -- very disorienting forcing draw-in any closer yalms
                    setEncounter(v, params)
                end

                if params.nextPos ~= nil then
                    local pos = params.nextPos[math.random(1, #params.nextPos)]
                    npc:setPos(unpack(pos))
                end
            end
        end
    end
end

local function mobsAlive(player, entities, entityID)
    local mobInfo = getEntityInfo(entities, entityID)
    local zone    = player:getZone()
    local result  = zone:queryEntitiesByName("DE_" .. mobInfo.name)

    for k, v in pairs(result) do
        if v:isAlive() then
            player:printToPlayer("An encounter is already in progress.", xi.msg.channel.SYSTEM_3)
            return true
        end
    end

    return false
end

local function delaySpawn(player, npc, delay, entityTable, entities, hideSpawner, params)
    if entityTable.mob ~= nil then
        for k, v in pairs(entityTable.mob) do
            if mobsAlive(player, entities, v) then
                return false
            end
        end
    else
        if type(entityTable) == "table" then
            for k, v in pairs(entityTable) do
                if mobsAlive(player, entities, v) then
                    return false
                end
            end
        else
            if mobsAlive(player, entities, entityTable) then
                return false
            end
        end
    end

    if params ~= nil then
        if
            params.partySize ~= nil and
            player:getPartySize() > params.partySize
        then
            player:printToPlayer("Your party is too large to begin this encounter.", xi.msg.channel.SYSTEM_3)
            return false
        end

        if
            params.job ~= nil and
            player:getMainJob() ~= params.job
        then
            player:printToPlayer("Your job is incorrect for this encounter.", xi.msg.channel.SYSTEM_3)
            return false
        end
    end

    -- Only skip this if hideSpawner is false
    if
        ((params == nil or params.nextPos == nil) and
        hideSpawner == nil) or
        hideSpawner
    then
        hideNPC(npc)
    end

    applyLevelCap(player, params)

    npc:timer(delay, function(npcArg)
        if type(entityTable) == "table" then
            -- Use mobs and props
            if entityTable.mob ~= nil then
                for k, v in pairs(entityTable.mob) do
                    spawnMobID(player, npc, entities, v, params)
                end

                for k, v in pairs(entityTable.prop) do
                    local props = getEntities(player, v)

                    -- Props should be visible for entire party/alliance
                    for _, prop in pairs(props) do
                        local alliance = player:getAlliance()

                        for i = 1, #alliance do
                            prop:ceSpawn(alliance[i])
                        end
                    end
                end

            -- Use mobs only
            else
                for k, v in pairs(entityTable) do
                    spawnMobID(player, npc, entities, v, params)
                end
            end
        else
            spawnMobID(player, npc, entities, entityTable, params)
        end
    end)

    return true
end

local function allPlayers(player, func)
    local zoneID   = player:getZoneID()
    local alliance = player:getAlliance()

    for i = 1, #alliance do
        if
            alliance[i]:isPC() and
            alliance[i]:getZoneID() == zoneID
        then
            func(alliance[i])
        end
    end
end

m.tradeSpawn = function(mobID, items, params)
    return function(player, npc, trade, entity, var, step, entities)
        if
            params ~= nil and
            params.check ~= nil and
            not m.checks(params.check)(player)
        then
            player:fmt("Your party does not currently meet the requirements for this battle.")
            return false
        end

        if npcUtil.tradeHasExactly(trade, items) then
            local hideSpawner = true

            if params ~= nil and not params.hideSpawner then
                hideSpawner = false
            end

            if delaySpawn(player, npc, 0, mobID, entities, hideSpawner, params) then
                player:tradeComplete()

                if params ~= nil then
                    if params.flag ~= nil then
                        player:setLocalVar(params.flag, 1)
                    end

                    if params.instance ~= nil then
                        local value = GetServerVariable(params.instance) + 1
                        SetServerVariable(params.instance, value)

                        print(fmt("Created new instance #{} for {}", value, params.instance))

                        allPlayers(player, function(member)
                            member:setCharVar(params.instance, value, JstMidnight())
                        end)
                    end
                end
            else
                player:tradeRelease()
            end
        end
    end
end

m.menuSpawn = function(entityTable, title, opt, select, hideSpawner, params)
    if entityTable == nil then
        print("[CQ] menuSpawn entity table is not defined.")
        return
    end

    return function(player, npc, tbl, var, step, entities)
        -- Prevent players opening menu while in dialog
        if player:getLocalVar("[CU]BLOCKING") == 1 then
            return
        end

        local options = {}
        local i = 1

        for i = 1, #opt do
            if i == select then

                table.insert(options, {
                    opt[i][1],
                    function()
                        if entityTable.prop ~= nil then
                            for k, v in pairs(entityTable.prop) do
                                local props = getEntities(player, v)

                                for _, prop in pairs(props) do
                                    prop:ceSpawn(player)
                                end
                            end
                        end

                        local delay = 0

                        -- Perform dialog for all party members
                        if opt[i][2] ~= nil then
                            delay = cexi.util.dialogDelay(tbl.dialog[opt[i][2]])
                            local alliance = player:getAlliance()

                            for j = 1, #alliance do
                                cexi.util.dialog(alliance[j], tbl.dialog[opt[i][2]], dialogFrom(tbl), { npc = npc })
                            end
                        end

                        if
                            params ~= nil and
                            params.random ~= nil
                        then
                            local roll = math.random(1, #params.random)

                            if params.random[roll].dialog ~= nil then
                                npc:timer(delay, function()
                                    sayAll(player, params.random[roll].dialog, params.random[roll].channel)
                                end)
                            end

                            delaySpawn(player, npc, delay, params.random[roll].wave, entities, hideSpawner, params)
                        else
                            delaySpawn(player, npc, delay, entityTable, entities, hideSpawner, params)
                        end
                    end,
                })
            else
                table.insert(options, {
                    opt[i][1],
                    function()
                    end,
                })
            end
        end

        local delay = 0

        if type(title) == "table" then
            delay = cexi.util.dialogDelay(tbl.dialog[title[1]])
            cexi.util.dialog(player, tbl.dialog[title[1]], dialogFrom(tbl), { npc = npc })

            player:timer(delay, function(playerArg)
                playerArg:customMenu({
                    title   = title[2],
                    options = options,
                })
            end)
        else
            player:customMenu({
                title   = title,
                options = options,
            })
        end
    end
end

-- Menu based rewards, repeatable until all collected
m.menuReward = function(obj)
    return function(player, npc, tbl, var, step)
        -- Prevent players opening menu while in dialog
        if player:getLocalVar("[CU]BLOCKING") == 1 then
            return
        end

        local options = {}
        local i = 1

        local progress = player:getCharVar(obj.progress[1])

        for i = 1, #obj.options do
            if utils.mask.getBit(progress, i) == false then
                table.insert(options, {
                    obj.options[i][1],
                    function()
                        local delay = cexi.util.dialogDelay(tbl.dialog[obj.message[2]])
                        cexi.util.dialog(player, tbl.dialog[obj.message[2]], dialogFrom(tbl), { npc = npc })
                        player:setLocalVar("[CU]REWARD", 1)

                        npc:timer(delay, function(playerArg)
                            if npcUtil.giveItem(player, obj.options[i][2]) then
                                local result = utils.mask.setBit(progress, i, true)

                                player:setCharVar(obj.progress[1], result)
                                m.questCompleted(player, obj.complete[1], obj.complete[2])

                                -- Check if all options are now received
                                local finished = true

                                for j = 1, #obj.options do
                                    if not utils.mask.getBit(result, j) then
                                        finished = false
                                    end
                                end

                                if finished then
                                    -- Quest completed, advance to end
                                    player:setCharVar(var, step)
                                else
                                    -- Reset to previous step
                                    player:setCharVar(var, obj.progress[2])
                                end
                            end

                            player:setLocalVar("[CU]REWARD", 0)
                        end)
                    end,
                })
            end
        end

        player:customMenu({
            title   = obj.message[1],
            options = options,
        })
    end
end

m.menu = function(obj)
    return function(player, npc, tbl, var, step, entities)
        -- Prevent players opening menu while in dialog
        if player:getLocalVar("[CU]BLOCKING") == 1 then
            return
        end

        if
            obj.check ~= nil and
            not obj.check(player)
        then
            if
                obj.default ~= nil and
                player:getCharVar(obj.default.condition[1]) == obj.default.condition[2]
            then
                cexi.util.dialog(player, obj.default.dialog, obj.name, { npc = npc })
            else
                cexi.util.dialog(player, tbl.dialog.DEFAULT, obj.name, { npc = npc })
            end

            return
        end

        local options = {}
        local i = 1

        for i = 1, #obj.options do
            table.insert(options, {
                obj.options[i][1],
                function()
                    if obj.options[i][2] ~= nil then
                        if type(obj.options[i][2]) == "boolean" then
                            if obj.spawn ~= nil then
                                if obj.flag ~= nil then
                                    player:setLocalVar(obj.flag, 1)
                                end

                                if obj.spawn.hq ~= nil then
                                    local mobID = obj.spawn.nq

                                    if math.random(0, 100) < obj.spawn.rate then
                                        mobID = obj.spawn.hq
                                    end

                                    if delaySpawn(player, npc, 0, mobID, entities, true, {
                                        levelCap = obj.levelCap,
                                        raiseAllowed = obj.raiseAllowed
                                    }) then
                                        if obj.setVar ~= nil then
                                            for _, varInfo in pairs(obj.setVar) do
                                                player:setCharVar(varInfo[1], varInfo[2])
                                            end

                                            if obj.setVarAll ~= nil then
                                                allPlayers(player, function(member)
                                                    member:setCharVar(obj.setVarAll[1], obj.setVarAll[2])
                                                end)
                                            end
                                        end
                                    end
                                else
                                    for _, mobID in pairs(obj.spawn) do

                                        if obj.nextPos ~= nil then
                                            if delaySpawn(player, npc, 0, mobID, entities, true, {
                                                setPos       = npc:getPos(),
                                                nextPos      = obj.nextPos,
                                                levelCap     = obj.levelCap,
                                                raiseAllowed = obj.raiseAllowed,
                                                partySize    = obj.partySize,
                                                scaleVar     = obj.scaleVar,
                                            }) then
                                                if obj.setVar ~= nil then
                                                    for _, varInfo in pairs(obj.setVar) do
                                                        player:setCharVar(varInfo[1], varInfo[2])
                                                    end
                                                end
                                            end
                                        else
                                            if delaySpawn(player, npc, 0, mobID, entities, true, {
                                                levelCap     = obj.levelCap,
                                                raiseAllowed = obj.raiseAllowed,
                                                partySize    = obj.partySize,
                                                scaleVar     = obj.scaleVar,
                                            }) then
                                                if obj.setVar ~= nil then
                                                    for _, varInfo in pairs(obj.setVar) do
                                                        player:setCharVar(varInfo[1], varInfo[2])
                                                    end
                                                end
                                            end

                                            if obj.setVarAll ~= nil then
                                                allPlayers(player, function(member)
                                                    member:setCharVar(obj.setVarAll[1], obj.setVarAll[2])
                                                end)
                                            end
                                        end
                                    end
                                end
                            end

                            return
                        end

                        local delay = cexi.util.dialogDelay(obj.options[i][2])
                        cexi.util.dialog(player, obj.options[i][2], obj.name, { npc = npc })

                        if obj.options[3] ~= nil then
                            if player:getLocalVar("[CU]REWARD") == 1 then
                                return
                            end

                            player:setLocalVar("[CU]REWARD", 1)
                        end

                        npc:timer(delay, function(playerArg)
                            -- Optionally give item after dialog
                            if obj.options[i][3] ~= nil then
                                if npcUtil.giveItem(player, obj.options[3]) then
                                    player:setCharVar(var, step)

                                    if obj.quest ~= nil then
                                        m.questAccepted(player, obj.quest, false)
                                    elseif obj.mission ~= nil then
                                        m.newMission(player, obj.mission)
                                    end
                                end
                            else
                                player:setCharVar(var, step)

                                if obj.quest ~= nil then
                                    if obj.finish ~= nil then
                                        m.questCompleted(player, obj.quest, obj.music, false)
                                    else
                                        m.questAccepted(player, obj.quest, false)
                                    end
                                elseif obj.mission ~= nil then
                                   m.newMission(player, obj.mission)
                                end
                            end

                            player:setLocalVar("[CU]REWARD", 0)
                        end)
                    end
                end,
            })
        end

        player:customMenu({
            title   = obj.title,
            options = options,
        })
    end
end


m.menuStep = function(title, opt, select, questName, finish, music, isMission)
    return function(player, npc, tbl, var, step)
        -- Prevent players opening menu while in dialog
        if player:getLocalVar("[CU]BLOCKING") == 1 then
            return
        end

        local options = {}
        local i = 1

        for i = 1, #opt do
            if i == select then

                table.insert(options, {
                    opt[i][1],
                    function()
                        if opt[i][2] ~= nil then
                            local delay = cexi.util.dialogDelay(tbl.dialog[opt[i][2]])
                            cexi.util.dialog(player, tbl.dialog[opt[i][2]], dialogFrom(tbl), { npc = npc })

                            if opt[i][3] ~= nil then
                                if player:getLocalVar("[CU]REWARD") == 1 then
                                    return
                                end

                                player:setLocalVar("[CU]REWARD", 1)
                            end

                            npc:timer(delay, function(playerArg)
                                -- Optionally give item after dialog
                                if opt[i][3] ~= nil then
                                    if npcUtil.giveItem(player, opt[i][3]) then
                                        player:setCharVar(var, step)

                                        if questName ~= nil then
                                            m.questAccepted(player, questName, isMission)
                                        end
                                    end
                                else
                                    player:setCharVar(var, step)

                                    if questName ~= nil then
                                        if finish ~= nil then
                                            m.questCompleted(player, questName, music, isMission)
                                        else
                                            m.questAccepted(player, questName, isMission)
                                        end
                                    end
                                end

                                player:setLocalVar("[CU]REWARD", 0)
                            end)
                        end
                    end,
                })
            else
                table.insert(options, {
                    opt[i][1],
                    function()
                        if opt[i][2] ~= nil then
                            cexi.util.dialog(player, tbl.dialog[opt[i][2]], dialogFrom(tbl), { npc = npc })
                        end
                    end,
                })
            end
        end

        player:customMenu({
            title   = title,
            options = options,
        })
    end
end

local giveReward = function(player, reward)
    if reward.item ~= nil then
        if reward.augment ~= nil then
            local ID = zones[player:getZoneID()]

            if player:getFreeSlotsCount() > 0 then
                player:addItem(reward.item, 1, unpack(reward.augment))
                player:messageSpecial(ID.text.ITEM_OBTAINED, reward.item)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward.item)
                return false
            end
        elseif not npcUtil.giveItem(player, reward.item) then
            return false
        end
    end

    if reward.gil ~= nil then
        npcUtil.giveCurrency(player, "gil", reward.gil)
    end

    if reward.keyitem ~= nil then
        if type(reward.keyitem) == "table" then
            for _, keyItem in pairs(reward.keyitem) do
                npcUtil.giveKeyItem(player, keyItem)
            end
        else
            npcUtil.giveKeyItem(player, reward.keyitem)
        end
    end

    return true
end

local giveAfter = function(player, reward)
    if
        reward ~= nil and
        type(reward) == "table" and
        reward.after ~= nil
    then
        local result = reward.after(player)

        if type(result) ~= "boolean" then
            print("[CQ] Reward \"after\" function did not return a boolean!")
            return false
        else
            return result
        end
    end
end

m.restoreJob = function(text, name, music)
    return function(player, npc, tbl, var, step)
        local deaths = player:getDeaths()

        if #deaths > 0 then
            local options =
            {
                {
                    "None",
                    function()
                    end,
                },
            }

            for k, v in pairs(deaths) do
                -- Only offer reset if lost level greater than current level
                if v[2] > player:getJobLevel(v[1]) then
                    table.insert(options, {
                        string.format("Lv%u %s", v[2], xi.jobNames[v[1]][2]),
                        function(playerArg)
                            player:changeJob(v[1])
                            player:setLevel(v[2] - 1)
                            player:addExp(1)

                            player:setCharVar(var, step)
                            player:setUnbreakable(false)

                            cexi.util.dialog(player, tbl.dialog[text], dialogFrom(tbl), { npc = npc })

                            local delay = cexi.util.dialogDelay(tbl.dialog[text])

                            playerArg:timer(delay, function()
                                m.questCompleted(player, name, music)
                            end)
                        end,
                    })
                end
            end

            -- If no jobs viable for rollback, just proceed
            if #options == 1 then
                player:setCharVar(var, step)
                player:setUnbreakable(false)

                cexi.util.dialog(player, tbl.dialog[text], dialogFrom(tbl), { npc = npc })

                local delay = cexi.util.dialogDelay(tbl.dialog[text])

                player:timer(delay, function(playerArg)
                    m.questCompleted(playerArg, name, music)
                end)

                return
            end

            player:customMenu({
                title   = "Restore previous job?",
                options = options
            })
        else
            player:setCharVar(var, step)
            player:setUnbreakable(false)

            cexi.util.dialog(player, tbl.dialog[text], dialogFrom(tbl), { npc = npc })

            local delay = cexi.util.dialogDelay(tbl.dialog[text])

            playerArg:timer(delay, function()
                m.questCompleted(player, name, music)
            end)
        end
    end
end

m.giveStart = function(text, reward, name)
    return function(player, npc, tbl, var, step)
        if player:getLocalVar("[CU]REWARD") == 1 then
            return
        end

        player:setLocalVar("[CU]REWARD", 1)
        local delay = cexi.util.dialogDelay(tbl.dialog[text])
        cexi.util.dialog(player, tbl.dialog[text], dialogFrom(tbl), { npc = npc })

        player:timer(delay, function(playerArg)
            if giveReward(player, reward) then
                player:setCharVar(var, step)
                giveAfter(player, reward)

                if name ~= nil then
                    m.questAccepted(player, name)
                end
            end

            player:setLocalVar("[CU]REWARD", 0)
        end)
    end
end

m.giveStep = function(text, reward, name, music, isMission)
    return function(player, npc, tbl, var, step)
        if player:getLocalVar("[CU]REWARD") == 1 then
            return
        end

        player:setLocalVar("[CU]REWARD", 1)
        local delay = cexi.util.dialogDelay(tbl.dialog[text])
        cexi.util.dialog(player, tbl.dialog[text], dialogFrom(tbl), { npc = npc })

        player:timer(delay, function(playerArg)
            if giveReward(player, reward) then
                player:setCharVar(var, step)
                giveAfter(player, reward)

                if name ~= nil then
                    m.questCompleted(player, name, music, isMission)
                end
            end

            player:setLocalVar("[CU]REWARD", 0)
        end)
    end
end

m.giveConditional = function(condition, text, reward)
    return function(player, npc, tbl, var, step)
        if player:getLocalVar("[CU]REWARD") == 1 then
            return
        end

        player:setLocalVar("[CU]REWARD", 1)

        if condition == "job" then
            local job   = player:getMainJob()
            local delay = cexi.util.dialogDelay(tbl.dialog[text][job])
            cexi.util.dialog(player, tbl.dialog[text][job], dialogFrom(tbl), { npc = npc })

            player:timer(delay, function(playerArg)
                if npcUtil.giveItem(player, reward[job]) then
                    player:setCharVar(var, step)
                end

                player:setLocalVar("[CU]REWARD", 0)
            end)
        end
    end
end

local checkList =
{
    gm = function(player, val)
        return (player:getGMLevel() > 0) == val
    end,

    level = function(player, val)
        return player:getMainLvl() >= val
    end,

    job  = function(player, val)
        return player:getMainJob() == val
    end,

    jobvar = function(player, var)
        return player:getMainJob() == player:getCharVar(var)
    end,

    vareq = function(player, val)
        return player:getCharVar(val[1]) == val[2]
    end,

    varin = function(player, tbl)
        local val = player:getCharVar(tbl[1])

        for _, varVal in pairs(tbl[2]) do
            if val == varVal then
                return true
            end
        end

        return false
    end,

    vargt = function(player, val)
        return player:getCharVar(val[1]) > val[2]
    end,

    varlt = function(player, val)
        return player:getCharVar(val[1]) < val[2]
    end,

    zero = function(player, variable)
        return player:getCharVar(variable) == 0
    end,

    allzero = function(player, variable)
        local zoneID   = player:getZoneID()
        local alliance = player:getAlliance()

        for _, member in pairs(alliance) do
            if
                member ~= nil and
                member:isPC() and
                member:getZoneID() == zoneID
            then
                if member:getCharVar(variable) ~= 0 then
                    return false
                end
            end
        end

        return true
    end,

    timeout = function(player, variable)
        return os.time() < player:getCharVar(variable)
    end,

    cooldown = function(player, variable)
        return os.time() > player:getCharVar(variable)
    end,

    bool = function(player, val)
        return val
    end,

    item = function(player, item)
        return player:hasItem(item)
    end,
}

m.checks = function(tbl)
    return function(player)
        local pass = true

        for k, v in pairs(tbl) do
            if not checkList[string.lower(k)](player, v) then
                pass = false
            end
        end

        return pass
    end
end

m.spawnMob = function(entityID, text, hideSpawner, params)
    return function(player, npc, entity, var, step, entities)
        local mobInfo = getEntityInfo(entities, entityID)
        local delay   = 0

        if mobsAlive(player, entities, entityID) then
            return
        end

        if text then
            delay = cexi.util.dialogDelay(entity.dialog[text])
            cexi.util.dialog(player, entity.dialog[text], dialogFrom(entity), { npc = npc })
        end

        npc:timer(delay, function(npcArg)
            if mobsAlive(player, entities, entityID) then
                return
            end

            local zone       = player:getZone()
            local result     = zone:queryEntitiesByName("DE_" .. mobInfo.name)

            -- Only skip this if hideSpawner is false
            if hideSpawner == nil or hideSpawner then
                hideNPC(npcArg)
            end

            applyLevelCap(player, params)

            for k, v in pairs(result) do
                 if v and not v:isAlive() then
                    v:setSpawn(mobInfo.pos[1], mobInfo.pos[2], mobInfo.pos[3], mobInfo.pos[4])

                    if mobInfo.dropID ~= nil then
                        v:setDropID(mobInfo.dropID)
                    else
                        v:setDropID(0)
                    end

                    v:spawn()
                    v:setMobLevel(mobInfo.level)
                    v:updateClaim(player)
                    v:setLocalVar("NO_CASKET", 1)
                    v:setRespawnTime(0)

                    if mobInfo.mods ~= nil then
                        for mod, value in pairs(mobInfo.mods) do
                            v:setMod(mod, value)
                        end
                    end

                    if mobInfo.hp ~= nil then
                        local mobHP = v:getMaxHP()
                        local hpp   = math.max(math.ceil((mobInfo.hp / mobHP) * 100) - 100, 0)
                        v:addMod(xi.mod.HPP, hpp)
                        v:updateHealth()
                        v:setHP(v:getMaxHP())
                    end

                    if
                        params ~= nil and
                        params.levelCap ~= nil
                    then
                        v:setMobMod(xi.mobMod.DRAW_IN, 15)
                        setEncounter(v, params)
                    end
                end
            end
        end)
    end
end

local getSteps = function(var, entity, steps, entities)
    local func = getStepFunctions(steps, entity.id)

    return function(player, npc)
        if entity.dialog == nil then
            return
        end

        local step = player:getCharVar(var) + 1

        if
            func[step] == nil or
            (
                steps[step].check and
                not steps[step].check(player)
            )
        then
            cexi.util.dialog(player, entity.dialog.DEFAULT, dialogFrom(entity))
        else
            if type(func[step]) == "table" then
                if func[step]["onTrigger"] ~= nil then
                    if
                        func[step].check and
                        not func[step].check(player)
                    then
                        cexi.util.dialog(player, entity.dialog.DEFAULT, dialogFrom(entity))
                        return
                    end

                    func[step]["onTrigger"](player, npc, entity, var, step, entities)
                else
                    cexi.util.dialog(player, entity.dialog.DEFAULT, dialogFrom(entity))
                end
            else
                func[step](player, npc, entity, var, step, entities)
            end
        end
    end
end

local function awardGive(player, var, reward)
    local var = string.format("[HELPER]%s", string.upper(var))

    -- Make sure player can't claim reward more than once every 24 hours
    if player:getCharVar(var) == 0 then
        print(string.format("[HELPER] %s has claimed a reward for helping with %s.", player:getName(), var))
        player:setCharVar(var, 1, getMidnight())

        -- Increment var for helper points and leaderboards
        player:incrementCharVar("[HELPER]POINTS", 1)

        -- If player's inventory is full, increment var to receive later
        if not npcUtil.giveItem(player, reward) then
            player:incrementCharVar("[HELPER]EXP_SCROLL", 1)
        end
    end
end

local function forAllPlayers(player, var, updatedStep, params, check, func)
    local zoneID   = player:getZoneID()
    local alliance = player:getAlliance()

    for i = 1, #alliance do
        if
            alliance[i]:isPC() and
            alliance[i]:getZoneID() == zoneID and
            ((alliance[i]:getCharVar(var) == updatedStep) or ((params ~= nil) and params.inclusive))
        then
            if
                check == nil or
                check(alliance[i])
            then
                func(alliance[i])
            end
        end
    end
end

local function awardHelper(player, var, updatedStep, params)
    local zoneID      = player:getZoneID()
    local alliance    = player:getAlliance()
    local cooldownVar = var .. "_HELPER"

    if params.var ~= nil then
        cooldownVar = params.var
    end

    for i = 1, #alliance do
        if
            alliance[i]:isPC() and 
            alliance[i]:getZoneID() == zoneID and
            alliance[i]:getCharVar(var) ~= updatedStep
        then
            awardGive(alliance[i], cooldownVar, params.helper)
        end
    end
end

local function messagePlayers(player, var, updatedStep, params, check)
    local zoneID   = player:getZoneID()
    local alliance = player:getAlliance()

    for i = 1, #alliance do
        if
            alliance[i]:isPC() and
            alliance[i]:getZoneID() == zoneID and
            alliance[i]:getCharVar(var) == updatedStep
        then
            if
                check == nil or
                check(alliance[i])
            then
                alliance[i]:printToPlayer(params.message, xi.msg.channel.SYSTEM_3)
            end
        end
    end
end

local function raisePlayers(player, raiseLevel)
    local zoneID   = player:getZoneID()
    local alliance = player:getAlliance()

    for i = 1, #alliance do
        if
            alliance[i]:isPC() and
            alliance[i]:getZoneID() == zoneID and
            alliance[i]:isDead()
        then
            alliance[i]:sendRaise(raiseLevel)
        end
    end
end

local function expPlayers(player, var, updatedStep, params, check)
    forAllPlayers(player, var, updatedStep, params, check, function(member)
        member:addExp(params.exp)
    end)
end

local function pointsPlayers(player, var, updatedStep, params, check, multiply)
    forAllPlayers(player, var, updatedStep, params, check, function(member)
        local total = params.points

        if multiply ~= nil then
            total = utils.clamp(params.points * multiply, params.multiplier.range[1], params.multiplier.range[2]) + math.random(1, params.points)
        else
            if type(params.points) == "table" then
                total = math.random(params.points[1], params.points[2])
            end
        end

        member:incrementCharVar(params.pointsVar, total)
        member:sys(params.message, member:getName(), total)
    end)
end

local function cooldownPlayers(player, var, updatedStep, params, check)
    forAllPlayers(player, var, updatedStep, params, check, function(member)
        member:setCharVar(params.cooldown, 1, getMidnight())
    end)
end

m.respawnSpawner = function(player, entities, entityID)
    local spawner = entityFromID(player, entities, entityID)

    if spawner then
        spawner:setStatus(xi.status.NORMAL)
    end
end

m.killStep = function(entityID, mobs, resetStep, params)
    return function(mob, player, entity, var, step, entities, check)
        if mob:getLocalVar("KILLED") == 1 then
            return
        end

        mob:setLocalVar("KILLED", 1)

        local pass = false

        if mobs ~= nil then
            local clear = true

            for k, v in pairs(mobs) do
                local ent = entityFromID(mob, entities, v)
                if ent:isAlive() then
                    clear = false
                end
            end

            if clear then
                pass = true
                if resetStep ~= nil then
                    resetAllStep(player, var, step - 1, resetStep, check, params)
                else
                    incrementAllStep(player, var, step - 1, check, params)
                end

                if params ~= nil then
                    if params.cooldown ~= nil then
                        setAllVar(player, params.cooldown, 1, getMidnight())
                    end

                    if params.setLocal ~= nil then
                        setAllLocalVar(player, params.setLocal.var, params.setLocal.val)
                    end
                end
            end
        else
            pass = true

            if resetStep ~= nil then
                resetAllStep(player, var, step - 1, resetStep, check)
            else
                incrementAllStep(player, var, step - 1, check, params)
            end
        end

        -- Always remove level cap when all enemies are dead
        if pass then
            removeLevelCap(player)

            if params ~= nil then
                local updatedStep = step

                if resetStep ~= nil then
                    updatedStep = resetStep
                end

                if params.helper ~= nil then
                    awardHelper(player, var, updatedStep, params)
                end

                if params.exp ~= nil then
                    expPlayers(player, var, updatedStep, params, check)
                end

                if params.message ~= nil then
                    if params.points ~= nil then
                        if params.multiplier ~= nil then
                            local multiply = mob:getLocalVar(params.multiplier.var)
                            pointsPlayers(player, var, updatedStep, params, check, multiply)
                        else
                            pointsPlayers(player, var, updatedStep, params, check)
                        end
                    else
                        messagePlayers(player, var, step, params, check)
                    end
                end

                if params.cooldown ~= nil then
                    cooldownPlayers(player, var, updatedStep, params, check)
                end

                if params.func ~= nil then
                    params.func(player, step - 1)
                end

                if params.raise ~= nil then
                    raisePlayers(player, params.raise)
                end
            end
        end

        -- Respawn spawner
        if pass and entityID ~= nil then
            local spawner = entityFromID(mob, entities, entityID)

            if spawner then
                spawner:setStatus(xi.status.NORMAL)
            end
        end
    end
end

m.tradeStep = function(success, decline, items, reward, questName, music, isMission)
    return function(player, npc, trade, entity, var, step)
        if player:getLocalVar("[CU]REWARD") == 1 then
            return
        end

        if npcUtil.tradeHasExactly(trade, items) then
            player:setLocalVar("[CU]REWARD", 1)
            local delay = cexi.util.dialogDelay(entity.dialog[success])
            cexi.util.dialog(player, entity.dialog[success], dialogFrom(entity), { npc = npc })

            player:timer(delay, function(playerArg)
                if
                    reward == nil or
                    giveReward(player, reward)
                then
                    player:tradeComplete()
                    player:incrementCharVar(var, 1)
                    giveAfter(player, reward)

                    if questName ~= nil then
                        m.questCompleted(player, questName, music, isMission)
                    end

                    player:setLocalVar("[CU]REWARD", 0)
                else
                    player:tradeRelease()
                end
            end)
        else
            cexi.util.dialog(player, entity.dialog[decline], dialogFrom(entity), { npc = npc })
        end
    end
end

local function performTrade(obj, player, var, count, increment, items, multiple)
    if
        (obj.reward == nil and items == nil) or
        cexi.util.giveItem(player, items or obj.reward, { multiple = multiple })
    then
        player:tradeComplete()

        if
            obj.step == nil or
            obj.step
        then
            player:incrementCharVar(var, increment or 1)
        end

        if obj.reward ~= nil then
            giveAfter(player, obj.reward)
        end

        if obj.quest ~= nil then
            m.questCompleted(player, obj.quest, obj.music, false)
        elseif obj.mission ~= nil then
            m.newMission(player, obj.mission)
        end

        if obj.tally ~= nil then
            player:incrementCharVar(obj.tally, count)
        end

        player:setLocalVar("[CU]REWARD", 0)
    else
        player:tradeRelease()
    end
end

m.trade = function(obj)
    return function(player, npc, trade, entity, var, step)
        if player:getLocalVar("[CU]REWARD") == 1 then
            return
        end

        if obj.list ~= nil then
            for _, tradeInfo in pairs(obj.list) do
                if npcUtil.tradeHasExactly(trade, tradeInfo.required) then
                    player:setLocalVar("[CU]REWARD", 1)
                    local delay = cexi.util.dialogDelay(tradeInfo.accepted)
                    cexi.util.dialog(player, tradeInfo.accepted, obj.name, { npc = npc })

                    player:timer(delay, function(playerArg)
                        performTrade(obj, player, var, nil, tradeInfo.increment)
                    end)

                    return
                end
            end
        elseif obj.exchange ~= nil then
            local totalQtyTraded = 0

            for i = 0, trade:getSlotCount()-1 do
                local itemID = trade:getItemId(i)

                if
                    (obj.exchange[itemID] == nil and
                    obj.sellrate == nil) or
                    (obj.exclude ~= nil and obj.exclude[itemID])
                then
                    cexi.util.dialog(player, obj.declined, obj.name, { npc = npc })
                    return
                end

                totalQtyTraded = totalQtyTraded + trade:getSlotQty(i)
            end

            if obj.sellrate == nil then
                if player:getFreeSlotsCount() < totalQtyTraded then
                    player:sys("You don't have enough inventory space.")
                    return
                end
            end

            player:setLocalVar("[CU]REWARD", 1)

            local delay = cexi.util.dialogDelay(obj.accepted)
            cexi.util.dialog(player, obj.accepted, obj.name, { npc = npc })

            player:timer(delay, function(playerArg)
                local givenGil = 0
                local results  = {}

                for i = 0, trade:getSlotCount()-1 do
                    local slotID   = trade:getItemId(i)
                    local slotQty  = trade:getSlotQty(i)

                    for j = 1, slotQty do
                        if
                            obj.exchange[slotID] == nil and
                            obj.sellrate ~= nil
                        then
                            local item  = GetItemByID(slotID)
                            local value = item:getBasePrice()

                            if value == 0 then
                                value = 1
                            end

                            local total = math.floor(value * obj.sellrate) + 1
                            local flags = item:getFlag()

                            -- Ex items are worth an extra 10g
                            if bit.band(item:getFlag(), xi.itemFlag.EX) ~= 0 then
                                total = total + 10
                            end

                            -- Rare items are worth an extra 50g
                            if bit.band(item:getFlag(), xi.itemFlag.RARE) ~= 0 then
                                total = total + 50
                            end

                            givenGil = givenGil + total
                        else
                            local exchangeList = obj.exchange[slotID]

                            -- Allow the item table to be filtered by a conditional function
                            if obj.conditional ~= nil then
                                exchangeList = obj.conditional(player, obj.exchange[slotID])
                            end

                            local result  = cexi.util.pickItem(exchangeList)
                            local givenID = result[2]

                            if type(givenID) == "table" then
                                if givenID.gil ~= nil then
                                    givenGil = givenGil + givenID.gil
                                end
                            else
                                local givenQty = 1

                                if
                                    result[4] ~= nil and
                                    type(result[4]) == "table"
                                then
                                    givenQty = math.random(result[4][1], result[4][2])
                                end

                                results[givenID] = (results[givenID] or 0) + givenQty
                            end
                        end
                    end
                end

                local items = {}

                for itemID, itemQty in pairs(results) do
                    -- This will preventing locking the trade container when it fails to give an item
                    if player:canObtainItem(itemID) then
                        table.insert(items, { itemID, itemQty })
                    elseif
                        -- if the exchange defines a replcement for this itemid if it's unobtainable (player already has)
                        obj.replacements ~= nil and
                        obj.replacements[itemID]
                    then
                        table.insert(items, obj.replacements[itemID])
                    else
                        -- otherwise just replace it with a cluster, everyone loves clusters
                        local clusters =
                        {
                            xi.item.FIRE_CLUSTER,
                            xi.item.ICE_CLUSTER,
                            xi.item.WIND_CLUSTER,
                            xi.item.EARTH_CLUSTER,
                            xi.item.LIGHTNING_CLUSTER,
                            xi.item.WATER_CLUSTER,
                            xi.item.LIGHT_CLUSTER,
                            xi.item.DARK_CLUSTER,
                        }
                        table.insert(items, clusters[math.random(#clusters)])
                    end
                end

                performTrade(obj, player, var, totalQtyTraded, nil, items, true)

                if givenGil > 0 then
                    npcUtil.giveCurrency(player, "gil", givenGil)

                    if obj.points ~= nil then
                        local givenPts = math.floor(givenGil / 10) + 1
                        player:incrementCharVar(obj.points.var, givenPts)
                        player:sys("{} gains {} {}.", player:getName(), givenPts, obj.points.name)
                    end
                end
            end)

            return
        else
            local count = trade:getItemCount()
            local total = count

            if obj.tally ~= nil then
                total = total + player:getCharVar(obj.tally)
            end

            if
                (obj.tally ~= nil and npcUtil.tradeHas(trade, { { obj.required, count } }, false)) or
                npcUtil.tradeHasExactly(trade, obj.required)
            then
                player:setLocalVar("[CU]REWARD", 1)
                local delay = cexi.util.dialogDelay(obj.accepted)
                cexi.util.dialog(player, obj.accepted, obj.name, { [1] = count, [2] = total, npc = npc })

                player:timer(delay, function(playerArg)
                    performTrade(obj, player, var, count)
                end)

                return
            end
        end

        cexi.util.dialog(player, obj.declined, obj.name, { npc = npc })
    end
end

m.tallyStep = function(success, decline, items, reward, tallyvar, tallyadd, questName, music)
    return function(player, npc, trade, entity, var, step)
        if player:getLocalVar("[CU]REWARD") == 1 then
            return
        end

        if npcUtil.tradeHasExactly(trade, items) then
            player:setLocalVar("[CU]REWARD", 1)
            local delay = cexi.util.dialogDelay(entity.dialog[success])

            if tallyvar ~= nil then
                local amount = player:getCharVar(tallyvar) + tallyadd
                player:setCharVar(tallyvar, amount)
                cexi.util.dialog(player, entity.dialog[success], dialogFrom(entity), { [1] = amount, npc = npc })
            else
                cexi.util.dialog(player, entity.dialog[success], dialogFrom(entity), { npc = npc })
            end

            player:timer(delay, function(playerArg)
                if
                    reward == nil or
                    giveReward(player, reward)
                then
                    player:tradeComplete()
                    player:incrementCharVar(var, 1)
                    giveAfter(player, reward)

                    if questName ~= nil then
                        m.questCompleted(player, questName, music)
                    end

                    player:setLocalVar("[CU]REWARD", 0)
                else
                    player:tradeRelease()
                end
            end)
        else
            cexi.util.dialog(player, entity.dialog[decline], dialogFrom(entity), { npc = npc })
        end
    end
end

m.tradeOnly = function(success, decline, items, reward, tallyvar, tallyadd, questName, music)
    return function(player, npc, trade, entity, var, step)
        if player:getLocalVar("[CU]REWARD") == 1 then
            return
        end

        if npcUtil.tradeHasExactly(trade, items) then
            player:setLocalVar("[CU]REWARD", 1)
            local delay = cexi.util.dialogDelay(entity.dialog[success])

            if tallyvar ~= nil then
                local amount = player:getCharVar(tallyvar) + tallyadd
                player:setCharVar(tallyvar, amount)
                cexi.util.dialog(player, entity.dialog[success], dialogFrom(entity), { [1] = amount, npc = npc })
            else
                cexi.util.dialog(player, entity.dialog[success], dialogFrom(entity), { npc = npc })
            end

            player:timer(delay, function(playerArg)
                if
                    reward == nil or
                    giveReward(player, reward)
                then
                    player:tradeComplete()
                    giveAfter(player, reward)

                    if questName ~= nil then
                        m.questCompleted(player, questName, music)
                    end

                    player:setLocalVar("[CU]REWARD", 0)
                else
                    player:tradeRelease()
                end
            end)
        else
            cexi.util.dialog(player, entity.dialog[decline], dialogFrom(entity), { npc = npc })
        end
    end
end

m.tradeCount = function(tbl)
    return function(player, npc, trade, entity, var, step)
        if npcUtil.tradeHasExactly(trade, tbl.items) then
            local amount = player:getCharVar(tbl.var) + 6
            player:setCharVar(tbl.var, amount)

            if amount >= tbl.require then
                local delay = cexi.util.dialogDelay(entity.dialog[tbl.after[1]])
                cexi.util.dialog(player, entity.dialog[tbl.after[1]], dialogFrom(entity), { [1] = amount, npc = npc })

                player:timer(delay, function(playerArg)
                    if
                        tbl.after[2] == nil or
                        giveReward(player, tbl.after[2])
                    then
                        player:tradeComplete()
                        player:incrementCharVar(var, 1)
                        giveAfter(player, reward)

                        if tbl.questName ~= nil then
                            m.questCompleted(player, tbl.questName, tbl.music)
                        end
                    else
                        player:tradeRelease()
                    end
                end)
            else
                local delay = cexi.util.dialogDelay(entity.dialog[tbl.before[1]])
                cexi.util.dialog(player, entity.dialog[tbl.before[1]], dialogFrom(entity), { [1] = amount, npc = npc })

                player:timer(delay, function(playerArg)
                    if
                        tbl.before[2] == nil or
                        giveReward(player, tbl.before[2])
                    then
                        player:tradeComplete()
                        giveAfter(player, reward)

                        if tbl.questName ~= nil then
                            m.questCompleted(player, tbl.questName, tbl.music)
                        end
                    else
                        player:tradeRelease()
                    end
                end)
            end
        else
            cexi.util.dialog(player, entity.dialog[tbl.decline], dialogFrom(entity), { npc = npc })
        end
    end
end

local getTradeSteps = function(var, entity, steps, tbl)
    local func = getStepFunctions(steps, entity.id)

    return function(player, npc, trade)
        local step = player:getCharVar(var) + 1

        -- Do not attempt to call trade functions on dialog only step
        if
            func[step] ~= nil and
            type(func[step]) == "table" and
            func[step]["onTrade"]
        then
            if
                func[step].check and
                not func[step].check(player)
            then
                return
            end

            func[step]["onTrade"](player, npc, trade, entity, var, step, tbl)
        end
    end
end

m.transform = function(hp, model, skills, originalModel, originalSkills)
    return function(mob, target)
        if mob:getHPP() <= hp then
            -- Do some kind of animation
            mob:setModelId(model)
            mob:setMobMod(xi.mobMod.SKILL_LIST, skills)
        else
            mob:setModelId(originalModel)
            mob:setMobMod(xi.mobMod.SKILL_LIST, originalSkills)
        end
    end
end

local getMobSteps = function(event, var, entity, steps, entities)
    local func = getStepFunctions(steps, entity.id)

    return function(mob, player, optParams)
        -- TODO:
        -- How do we respawn the marker if we don't know the step?
        if player == nil then
            return
        end

        if
            entity.restore ~= nil and
            player:isPC() and
            optParams ~= nil and optParams.isKiller
        then
            player:setHP(player:getMaxHP())
            player:setMP(player:getMaxMP())
            player:setTP(3000)
        end

        if mob:getLocalVar("LOOT_ROLLED") == 0 then
            if entity.loot ~= nil then
                mob:setLocalVar("LOOT_ROLLED", 1)

                for _, itemInfo in pairs(entity.loot) do
                    player:addTreasure(itemInfo[2], mob, itemInfo[1])
                end
            end

            if entity.pool ~= nil then
                mob:setLocalVar("LOOT_ROLLED", 1)

                for _, pool in pairs(entity.pool) do
                    if pool.quantity ~= nil then
                        for _ = 1, pool.quantity do
                            local result = cexi.util.pickItem(pool)

                            if result[2] ~= 0 then
                                player:addTreasure(result[2], mob)
                            end
                        end
                    else
                        local result = cexi.util.pickItem(pool)

                        if result[2] ~= 0 then
                            player:addTreasure(result[2], mob)
                        end
                    end
                end
            end
        end

        if
            entity.points ~= nil and
            mob:getLocalVar("POINTS_ROLLED") == 0
        then
            mob:setLocalVar("POINTS_ROLLED", 1)

            allPlayers(player, function(member)
                if entity.points.exp ~= nil then
                    member:addExp(entity.points.exp)
                end

                if entity.points.amount ~= nil then
                    local amount = math.random(entity.points.amount[1], entity.points.amount[2])
                    member:incrementCharVar(entity.points.var, amount)
                    member:sys(entity.points.message, member:getName(), amount)
                end

                if entity.points.gil ~= nil then
                    npcUtil.giveCurrency(member, "gil", entity.points.gil)
                end

                if entity.points.item ~= nil then
                    if 
                        not npcUtil.giveItem(member, entity.points.item) and
                        entity.points.missed ~= nil
                    then
                        member:sys("Your missed item was stored at the relevant NPC.")
                        member:incrementCharVar(fmt(entity.points.missed, entity.points.item))
                    end
                end
            end)
        end

        if entity.casket ~= nil then
            cexi.aether.rollCasket(mob, player)
        end

        if entity.delCap ~= nil then
            allPlayers(player, function(member)
                member:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
            end)
        end

        if entity.tally ~= nil then
            allPlayers(player, function(member)
                member:incrementCharVar(entity.tally, 1)
            end)
        end

        local step = player:getCharVar(var) + 1

        if func[step] == nil then
            return
        end

        if type(func[step]) == "table" then
            if
                func[step].check ~= nil and
                not func[step].check(player)
            then
                return
            end

            if func[step][event] ~= nil then
                func[step][event](mob, player, entity, var, step, entities, func[step].check)
            end
        elseif event == "onMobDeath" then
            func[step](mob, player, entity, var, step, entities, nil)
        end
    end
end

local function entitySetup(dynamicEntity, tbl, entity)
    if
        entity.type == xi.objType.NPC or
        entity.marker ~= nil
    then
        dynamicEntity.onTrigger = getSteps(tbl.info.var, entity, tbl.step, tbl.entity)
        dynamicEntity.onTrade   = getTradeSteps(tbl.info.var, entity, tbl.step, tbl.entity)

    elseif entity.type == xi.objType.MOB then
        dynamicEntity.groupId     = entity.groupId
        dynamicEntity.groupZoneId = entity.groupZoneId

        dynamicEntity.onMobDeath     = getMobSteps("onMobDeath", tbl.info.var, entity, tbl.step, tbl.entity)
        dynamicEntity.onMobDisengage = function(mob)
            DespawnMob(mob:getID())
        end

        dynamicEntity.onMobInitialize = function(mob)
            mob:setMobMod(xi.mobMod.DETECTION, 0x08)
            mob:setMobMod(xi.mobMod.CHECK_AS_NM,  1)
            mob:setMobMod(xi.mobMod.CHARMABLE,    0)

            if entity.aeffect ~= nil then
                mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
            end

            if entity.jobSpecial then
                g_mixins.job_special(mob)
            end

            if entity.immunities ~= nil then
                for _, immunity in pairs(entity.immunities) do
                    mob:addImmunity(immunity)
                end
            end

            if entity.skillList ~= nil then
                mob:setMobMod(xi.mobMod.SKILL_LIST, entity.skillList)
            end

            if entity.spellList ~= nil then
                mob:setMobMod(xi.mobMod.SPELL_LIST, entity.spellList)
            end

            if entity.mobMods ~= nil then
                for mobModID, mobModValue in pairs(entity.mobMods) do
                    mob:setMobMod(mobModID, mobModValue)
                end
            end
        end

        if entity.onMobFight ~= nil then
            dynamicEntity.onMobFight = function(mob, target)
                entity.onMobFight(mob, target)
            end
        end

        if entity.onMobSpawn ~= nil then
            dynamicEntity.onMobSpawn = function(mob)
                entity.onMobSpawn(mob)
            end
        end

        if entity.onMobRoam ~= nil then
            dynamicEntity.onMobRoam = function(mob)
                entity.onMobRoam(mob)
            end
        end

        if entity.aeffect ~= nil then
            if type(entity.aeffect) == "table" then
                dynamicEntity.onAdditionalEffect = function(mob, target, damage)
                    return xi.mob.onAddEffect(mob, target, damage, entity.aeffect[1], { power = math.random(entity.aeffect[2], entity.aeffect[3]) })
                end
            else
                dynamicEntity.onAdditionalEffect = function(mob, target, damage)
                    return xi.mob.onAddEffect(mob, target, damage, entity.aeffect, { power = math.random(16, 26) })
                end
            end
        end
    end
end

local function entityAfter(de, entity)
    if entity.animation then
        de:setAnimation(entity.animation)
    end

    if entity.hidden then
        de:setStatus(xi.status.DISAPPEAR)
    end

    if entity.hidename ~= nil then
        de:hideName(entity.hidename)
    end

    -- Hide names and HP for side-quest/sparkle markers
    if entity.marker ~= nil then
        de:hideName(true)
        de:hideHP(true)
    end

    if entity.hidehp ~= nil then
        de:hideHP(entity.hidehp)
    end

    if entity.notarget ~= nil then
        de:setUntargetable(entity.notarget)
    end

    if
        entity.type == xi.objType.MOB and
        entity.dialog ~= nil
    then
        print(string.format("[CQ] %s is a mob but has been assigned dialog. Do not do this.", entyity.name))
    end
end

local function entityRefresh(dynamicEntity, zone, tbl, entity)
    local result = zone:queryEntitiesByName("DE_" .. entity.name)

    if result ~= nil then
        for _, de in pairs(result) do
            de:setPos(entity.pos[1], entity.pos[2], entity.pos[3], entity.pos[4])

            if type(entity.look) == "string" then
                de:setLookString(entity.look)

            -- TODO:
            elseif entity.marker == nil then
                de:setModelId(entity.look)
            end

            entityAfter(de, entity)
        end
        printf("[CQ] Entity DE_%s was updated.", entity.name)
    else
        printf("[CQ] Entity DE_%s not found.", entity.name)
    end
end

m.add = function(source, tbl)
    local zoneList  = {}
    tbl.entities = {}

    for k, v in pairs(tbl.entity) do
        if zoneList[v.area] == nil then
            zoneList[v.area] = {}
        end

        if v.id then
            zoneList[v.area][v.id] = v
        else
            print(string.format("[CQ] Entity %s has no defined ID", v.name))
        end
    end

    for k, v in pairs(zoneList) do
        if
            xi ~= nil and
            xi.zones ~= nil and
            xi.zones[k] ~= nil and
            xi.zones[k].npcs ~= nil
        then
            for id, entity in pairs(v) do
                local dynamicEntity = xi.zones[k].npcs["DE_" .. entity.name]

                if dynamicEntity ~= nil then
                    entitySetup(dynamicEntity, tbl, entity)

                    local zone = GetZone(cexi.zone[k])

                    if zone ~= nil then
                        entityRefresh(dynamicEntity, zone, tbl, entity)
                    end
                end
            end
        end

        source:addOverride(string.format("xi.zones.%s.Zone.onInitialize", k), function(zone)
            super(zone)

            for id, entity in pairs(v) do
                local dynamicEntity =
                {
                    name        = entity.name,
                    packetName  = entity.packetName,
                    objtype     = entity.type or xi.objType.NPC,
                    namevis     = entity.namevis or 0,
                    entityFlags = entity.flags or 0,
                    x           = entity.pos[1],
                    y           = entity.pos[2],
                    z           = entity.pos[3],
                    rotation    = entity.pos[4] or 0,
                    widescan    = 1,
                }

                if entity.marker ~= nil then
                    if entity.marker == m.MAIN_QUEST then
                        dynamicEntity.look = m.marker.SHIMMER
                    else
                        dynamicEntity.look = m.marker.SPARKLE
                    end
                end

                if entity.look ~= nil then 
                    dynamicEntity.look = entity.look
                end

                entitySetup(dynamicEntity, tbl, entity)

                tbl.entities[id] = zone:insertDynamicEntity(dynamicEntity)

                entityAfter(tbl.entities[id], entity)
            end
        end)
    end
end

return m
