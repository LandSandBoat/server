-----------------------------------
-- A Century of Hardship
-- Mine Shaft #2716 mission battlefield
-----------------------------------
local mineshaftID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------

local content = BattlefieldMission:new({
    zoneId                = xi.zone.MINE_SHAFT_2716,
    battlefieldId         = xi.battlefield.id.CENTURY_OF_HARDSHIP,
    canLoseExp            = false,
    isMission             = true,
    allowTrusts           = true,
    maxPlayers            = 6,
    levelCap              = 60,
    timeLimit             = utils.minutes(30),
    index                 = 0,
    entryNpc              = '_0d0',
    exitNpcs              = { '_0d1', '_0d2', '_0d3' },
    missionArea           = xi.mission.log_id.COP,
    mission               = xi.mission.id.cop.THREE_PATHS,
    missionStatus         = xi.mission.status.COP.LOUVERANCE,
    missionStatusArea     = xi.mission.log_id.COP,
    requiredMissionStatus = 8,
    grantXP               = 1000,
})

-- Mob dialogue mapping for death messages
local mobDialogue =
{
    [mineshaftID.mob.MOVAMUQ  ] = { base = mineshaftID.text.MOVAMUQ_DIALOGUE,   offset = 6, mobskill = xi.mobSkill.FRYPAN_1         },
    [mineshaftID.mob.CHEKOCHUK] = { base = mineshaftID.text.CHEKOCHUK_DIALOGUE, offset = 6, mobskill = xi.mobSkill.GOBLIN_DICE_HEAL },
    [mineshaftID.mob.TRIKOTRAK] = { base = mineshaftID.text.TRIKOTRAK_DIALOGUE, offset = 6, mobskill = xi.mobSkill.SMOKEBOMB_1      },
    [mineshaftID.mob.SWIPOSTIK] = { base = mineshaftID.text.SWIPOSTIK_DIALOGUE, offset = 5, mobskill = xi.mobSkill.BOMB_TOSS_1      },
    [mineshaftID.mob.BUGBBY   ] = { base = mineshaftID.text.BUGBBY_DIALOGUE,    offset = 9, mobskill = 0 },
}

-- Helper to execute Moblin command sequence
local function handleMoblinCommand(moblin, bugbear, offset)
    if not moblin or not bugbear then
        return
    end

    local moblinID = moblin:getID()
    local baseMobID = moblinID - offset
    moblin:setLocalVar('inCommandSequence', GetSystemTime() + 3)
    bugbear:setLocalVar('inCommandSequence', GetSystemTime() + 3)

    -- Determine which Moblin this is and get dialogue/skill
    local dialogueBase = mobDialogue[baseMobID].base
    local refusalSkill = mobDialogue[baseMobID].mobskill

    local alreadyUsedMightyStrikes = bugbear:getLocalVar('usedMightyStrikes') == 1

    -- Moblin looks at Bugbear (or where he died)
    moblin:lookAt(bugbear:getPos())
    moblin:setAutoAttackEnabled(false)
    moblin:setMagicCastingEnabled(false)
    moblin:setMobMod(xi.mobMod.NO_MOVE, 1)
    moblin:setBehavior(bit.bor(moblin:getBehavior(), xi.behavior.NO_TURN))

    -- Select which command to give Bugbear (60% enmity, 30% TP move, 10% Mighty Strikes)
    local randomRoll = math.random(1, 100)
    local commandType = randomRoll <= 60 and 1 or randomRoll <= 90 and 2 or 3

    -- Moblin issues the command (commandType maps to message offset)
    moblin:messageText(moblin, dialogueBase + commandType - 1)

    -- If Bugbear is dead, react after delay
    if not bugbear:isAlive() then
        moblin:timer(2000, function(mobArg)
            mobArg:messageText(mobArg, dialogueBase + 4)
        end)

        return
    end

    -- Bugbear responds to the command
    bugbear:lookAt(moblin:getPos())
    bugbear:setAutoAttackEnabled(false)
    bugbear:setMobMod(xi.mobMod.NO_MOVE, 1)
    bugbear:setBehavior(bit.bor(bugbear:getBehavior(), xi.behavior.NO_TURN))

    -- Bugbear can refuse any command, or if Mighty Strikes is commanded but already used
    local bugbearRefuses = math.random(100) <= 20
    local forceRefusal = commandType == 3 and alreadyUsedMightyStrikes

    if bugbearRefuses or forceRefusal then
        -- Bugbear refuses
        local bugbearRefuseMsg = mineshaftID.text.BUGBBY_DIALOGUE + 6 + math.random(0, 1)
        bugbear:timer(1000, function(bugArg)
            bugArg:messageText(bugArg, bugbearRefuseMsg)
        end)

        -- Moblin insults Bugbear and uses their refusal skill
        moblin:timer(2000, function(mobArg)
            mobArg:messageText(mobArg, dialogueBase + 3)

            if refusalSkill then
                -- For Goblin Dice, add random offset to get variant
                if refusalSkill == xi.mobSkill.GOBLIN_DICE_HEAL then
                    refusalSkill = refusalSkill + math.random(0, 10)
                end

                mobArg:useMobAbility(refusalSkill)
            end
        end)

        return
    end

    -- Bugbby accepts the command
    local bugbearAcceptMsg = mineshaftID.text.BUGBBY_DIALOGUE + math.random(0, 5)
    bugbear:messageText(bugbear, bugbearAcceptMsg)

    -- Execute command based on type
    switch (commandType) : caseof
    {
        -- Command Type 1: Override Bugbear's enmity
        [1] = function()
            local moblinTarget = moblin:getTarget()
            if moblinTarget then
                bugbear:disengage()
                bugbear:updateEnmity(moblinTarget)
            end
        end,

        -- Command Type 2: Tell Bugbear to use a TP move
        [2] = function()
            bugbear:timer(2000, function(bugArg)
                bugArg:useMobAbility(xi.mobSkill.HEAVY_WHISK)
            end)
        end,

        -- Command Type 3: Tell Bugbear to use Mighty Strikes
        [3] = function()
            bugbear:timer(2000, function(bugArg)
                bugArg:useMobAbility(xi.jsa.MIGHTY_STRIKES)
                bugArg:setLocalVar('usedMightyStrikes', 1)
            end)
        end,
    }
end

function content:onBattlefieldEnter(player, battlefield)
    Battlefield.onBattlefieldEnter(self, player, battlefield)

    player:addListener('DEATH', 'CENTURY_HARDSHIP_DEATH', function(deadPlayer, killer)
        if not killer or not killer:isAlive() then
            return
        end

        local bf = deadPlayer:getBattlefield()
        if not bf then
            return
        end

        local offset = (bf:getArea() - 1) * 5
        local baseMobID = killer:getID() - offset
        local dialogue = mobDialogue[baseMobID]

        if dialogue then
            killer:messageText(killer, dialogue.base + dialogue.offset)
        end
    end)
end

function content:onBattlefieldLeave(player, battlefield, leavecode)
    Battlefield.onBattlefieldLeave(self, player, battlefield, leavecode)
    player:removeListener('CENTURY_HARDSHIP_DEATH')
end

function content:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    local area    = battlefield:getArea()
    local offset  = (area - 1) * 5
    local bugbear = GetMobByID(mineshaftID.mob.BUGBBY + offset)

    if not bugbear or not bugbear:isAlive() then
        return
    end

    -- Restore mobility for mobs whose inCommandSequence has expired
    for i = 0, 3 do
        local moblin = GetMobByID(mineshaftID.mob.MOVAMUQ + offset + i)
        if moblin and moblin:isAlive() then
            local inCommandSequence = moblin:getLocalVar('inCommandSequence')
            if inCommandSequence > 0 and GetSystemTime() >= inCommandSequence then
                moblin:setMobMod(xi.mobMod.NO_MOVE, 0)
                moblin:setAutoAttackEnabled(true)
                moblin:setMagicCastingEnabled(true)
                moblin:setBehavior(bit.band(moblin:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
                moblin:setLocalVar('inCommandSequence', 0)
            end
        end
    end

    local bugbearSequence = bugbear:getLocalVar('inCommandSequence')
    if
        bugbearSequence > 0 and
        GetSystemTime() >= bugbearSequence
    then
        bugbear:setMobMod(xi.mobMod.NO_MOVE, 0)
        bugbear:setAutoAttackEnabled(true)
        bugbear:setBehavior(bit.band(bugbear:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
        bugbear:setLocalVar('inCommandSequence', 0)
    end

    -- Check if a mob triggered a command via HP threshold
    local triggeredMobID = battlefield:getLocalVar('triggerMoblinCommand')
    if triggeredMobID > 0 then
        local moblin = GetMobByID(triggeredMobID)
        if moblin and moblin:isAlive() then
            handleMoblinCommand(moblin, bugbear, offset)
        end

        battlefield:setLocalVar('triggerMoblinCommand', 0)
    end

    -- Reset command sequence if mobs exit combat (party wipe)
    if not bugbear:isEngaged() and battlefield:getLocalVar('commandSequence') == 1 then
        battlefield:setLocalVar('commandSequence', 0)
        battlefield:setLocalVar('nextCommandTime', 0)
        return
    end

    -- Trigger: Bugbby drops below 90% HP, start command cycle
    if
        battlefield:getLocalVar('commandSequence') == 0 and
        bugbear:isAlive() and
        bugbear:getHPP() < 90
    then
        battlefield:setLocalVar('commandSequence', 1)
        battlefield:setLocalVar('nextCommandTime', GetSystemTime() + math.random(30, 60))
    end

    -- Global command timer - triggers a Moblin to command
    local nextCommandTime = battlefield:getLocalVar('nextCommandTime')
    if
        nextCommandTime > 0 and
        GetSystemTime() >= nextCommandTime and
        bugbear:isEngaged()
    then
        -- Find all alive Moblins
        local aliveMoblins = {}

        for i = 0, 3 do
            local moblin = GetMobByID(mineshaftID.mob.MOVAMUQ + offset + i)
            if moblin and moblin:isAlive() then
                table.insert(aliveMoblins, moblin)
            end
        end

        -- Pick alive Moblin to command Bugbear
        if #aliveMoblins > 0 then
            local selectedMoblin = aliveMoblins[math.random(1, #aliveMoblins)]
            handleMoblinCommand(selectedMoblin, bugbear, offset)
            -- Set next global command timer (30-60 seconds)
            battlefield:setLocalVar('nextCommandTime', GetSystemTime() + math.random(30, 60))
        end
    end
end

content.groups =
{
    {
        mobIds =
        {
            {
                mineshaftID.mob.MOVAMUQ,
                mineshaftID.mob.MOVAMUQ + 1,
                mineshaftID.mob.MOVAMUQ + 2,
                mineshaftID.mob.MOVAMUQ + 3,
                mineshaftID.mob.MOVAMUQ + 4,
            },

            {
                mineshaftID.mob.MOVAMUQ + 5,
                mineshaftID.mob.MOVAMUQ + 6,
                mineshaftID.mob.MOVAMUQ + 7,
                mineshaftID.mob.MOVAMUQ + 8,
                mineshaftID.mob.MOVAMUQ + 9,
            },

            {
                mineshaftID.mob.MOVAMUQ + 10,
                mineshaftID.mob.MOVAMUQ + 11,
                mineshaftID.mob.MOVAMUQ + 12,
                mineshaftID.mob.MOVAMUQ + 13,
                mineshaftID.mob.MOVAMUQ + 14,
            },
        },

        superlink = true,

        allDeath = function(battlefield, mob)
            battlefield:setStatus(xi.battlefield.status.WON)
        end,
    },
}

return content:register()
