local ID = zones[xi.zone.SEALIONS_DEN]

local tenzenFunctions = {}

tenzenFunctions.firstMeikyo = function(mob)
    mob:setAnimationSub(0)
    mob:useMobAbility(730) -- meikyo_shisui
    mob:setLocalVar('meikyo', 1)
    mob:setLocalVar('step', 1)
    mob:setLocalVar('twohourtrigger', 1) -- prevent tenzen from using second meikyo while first one is active
    mob:setLocalVar('twohourthreshold', math.random(45, 55)) -- set next meikyo hpp threshold
end

tenzenFunctions.secondMeikyo = function(mob)
    mob:useMobAbility(730) -- meikyo_shisui
    mob:setLocalVar('meikyo', 1)
    mob:setLocalVar('step', 1)
    mob:setLocalVar('twohourtrigger', 3)
end

tenzenFunctions.wsSequence = function(mob)
    local step = mob:getLocalVar('step')
    local meikyo = mob:getLocalVar('meikyo')

    if
        step == 1 and
        meikyo == 1
    then
        mob:setTP(0)
        mob:setMod(xi.mod.DELAY, 0)
        mob:setAnimationSub(0)
        mob:setMobSkillAttack(0)
        mob:setMobAbilityEnabled(false) -- we don't want tenzen to randomly use WS during this phase
        mob:setAutoAttackEnabled(false) -- no autoattacks while skillchaining
        mob:useMobAbility(1394) -- Hanaikusa
        mob:setLocalVar('step', 2)
    elseif step == 2 then
        mob:timer(250, function(mobArg)
            mobArg:useMobAbility(1390) -- Torimai
            mobArg:setLocalVar('step', 3)
        end)
    elseif step == 3 then
        mob:timer(250, function(mobArg)
            mobArg:useMobAbility(1391) -- Kazakiri
            mobArg:setLocalVar('step', 4)
        end)
    elseif step == 4 then
        if mob:getLocalVar('skillchain') > 75 then -- 25% chance to trigger skillchain
            mob:timer(250, function(mobArg)
                if mobArg:getLocalVar('skillchain') > 75 then
                    mobArg:useMobAbility(1395) -- Tsukikage
                    mobArg:setLocalVar('step', 5)
                    mobArg:getBattlefield():setLocalVar('fireworks', 1)
                end
            end)
        else
            mob:setLocalVar('changeTime', mob:getBattleTime()) -- don't go back to bow form right away
            mob:setLocalVar('step', 0)
            mob:setLocalVar('meikyo', 0) -- reset for next meikyo and allow tenzen to now swap to bow form
            mob:setLocalVar('skillchain', math.random(1, 100)) -- calculate next skillchain success chance
            mob:setMobAbilityEnabled(true)
            mob:setAutoAttackEnabled(true)

            if mob:getLocalVar('twohourtrigger') == 1 then
                mob:setLocalVar('twohourtrigger', 2) -- prevent tenzen from using second meikyo while first one is active
            end
        end
    elseif step == 5 then
        mob:useMobAbility(1399) -- Cosmic Elucidation
        mob:setLocalVar('step', 6)
        mob:timer(3000, function(mobArg)
            mobArg:getBattlefield():setLocalVar('gameover', mobArg:getBattlefield():getRemainingTime()) -- initiate loss condition trigger & record the time remaining
            mobArg:setMobMod(xi.mobMod.NO_MOVE, 1)
            mobArg:showText(mobArg, ID.text.TENZEN_MSG_OFFSET + 1)
        end)
    end
end

tenzenFunctions.formSwap = function(mob)
    local changeTime = mob:getLocalVar('changeTime')
    local battleTime = mob:getBattleTime()

    if mob:getLocalVar('meikyo') == 0 then
        if
            mob:getAnimationSub() == 0 and
            battleTime - changeTime > 60
        then
            mob:setAnimationSub(5) -- 5 lowered bow mode (1033 animation) 6 is raised bow mode (1034 animation)
            mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
            mob:setMobSkillAttack(1171)
            mob:setLocalVar('changeTime', mob:getBattleTime())

            if mob:getAnimationSub() == 5 then -- need to sheath his great katana before pulling out bow
                mob:timer(1000, function(mobArg)
                    mobArg:setMod(xi.mod.DELAY, 2400) -- attacks more frequently while bow is drawn
                    mobArg:setAnimationSub(6)
                end)
            end
        elseif
            mob:getAnimationSub() == 6 and
            battleTime - changeTime > 30
        then
            mob:setAnimationSub(0)
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.STANDBACK)))
            mob:setMobSkillAttack(0)
            mob:setMod(xi.mod.DELAY, 0) -- attack slower back to great katana
            mob:setLocalVar('changeTime', mob:getBattleTime())
        end
    end
end

tenzenFunctions.riceBall = function(mob, target, busyState)
    local battlefield = mob:getBattlefield()

    if
        mob:actionQueueEmpty() and
        not busyState
    then
        if
            mob:getHPP() <= 70 and
            mob:getLocalVar('riceball') == 0
        then
            if battlefield:getLocalVar('fireworks') ~= 1 then
                mob:showText(target, ID.text.TENZEN_MSG_OFFSET + 3)
                mob:useMobAbility(1398)
                mob:addMod(xi.mod.ATT, 50)
                mob:addMod(xi.mod.DEF, 30)
                mob:setMod(xi.mod.DOUBLE_ATTACK, 5)
                mob:addMod(xi.mod.DEX, 4)
                mob:addMod(xi.mod.VIT, 4)
                mob:addMod(xi.mod.CHR, 4)
                mob:setLocalVar('riceball', 1)
            end
        end
    end
end

return tenzenFunctions
