local ID = require("scripts/zones/Sealions_Den/IDs")

local TenzenFunctions = {}

TenzenFunctions.firstMeikyo = function(mob)
    mob:AnimationSub(0)
    mob:useMobAbility(730)
    mob:setLocalVar("meikyo", 1)
    mob:setLocalVar("step", 1)
    mob:setLocalVar("twohourtrigger", 1) -- prevent tenzen from using second meikyo while first one is active
    mob:setLocalVar("twohourthreshold", math.random(45, 55)) -- set next meikyo hpp threshold
end

TenzenFunctions.secondMeikyo = function(mob)
    mob:useMobAbility(730)
    mob:setLocalVar("meikyo", 1)
    mob:setLocalVar("step", 1)
    mob:setLocalVar("twohourtrigger", 3)
end

TenzenFunctions.wsSequence = function(mob)
    local step = mob:getLocalVar("step")
    local meikyo = mob:getLocalVar("meikyo")
    local battlefield = mob:getBattlefield()
    if step == 1 and meikyo == 1 then
        mob:setTP(0)
        mob:setMod(xi.mod.DELAY, 0)
        mob:AnimationSub(0)
        mob:SetMobSkillAttack(0)
        mob:SetMobAbilityEnabled(false) -- we don't want tenzen to randomly use WS during this phase
        mob:SetAutoAttackEnabled(false) -- no autoattacks while skillchaining
        mob:useMobAbility(1394) -- Hanaikusa
        mob:setLocalVar("step", 2)
    elseif step == 2 then
        mob:timer(250, function(mobArg)
            mob:useMobAbility(1390) -- Torimai
            mob:setLocalVar("step", 3)
        end)
    elseif step == 3 then
        mob:timer(250, function(mobArg)
            mob:useMobAbility(1391) -- Kazakiri
            mob:setLocalVar("step", 4)
        end)
    elseif step == 4 then
        if mob:getLocalVar("skillchain") > 75 then -- 25% chance to trigger skillchain
            mob:timer(250, function(mobArg)
                if mob:getLocalVar("skillchain") > 75 then
                    mob:useMobAbility(1395) -- Tsukikage
                    mob:setLocalVar("step", 5)
                    battlefield:setLocalVar("fireworks", 1)
                end
            end)
        else
            mob:setLocalVar("changeTime", mob:getBattleTime()) -- don't go back to bow form right away
            mob:setLocalVar("step", 0)
            mob:setLocalVar("meikyo", 0) -- reset for next meikyo and allow tenzen to now swap to bow form
            mob:setLocalVar("skillchain", math.random(100)) -- calculate next skillchain success chance
            mob:SetMobAbilityEnabled(true)
            mob:SetAutoAttackEnabled(true)
            if mob:getLocalVar("twohourtrigger") == 1 then
                mob:setLocalVar("twohourtrigger", 2) -- prevent tenzen from using second meikyo while first one is active
            end
        end
    elseif step == 5 then
        mob:useMobAbility(1399) -- Cosmic Elucidation
        mob:setLocalVar("step", 6)
        mob:timer(3000, function(mobArg, target)
            battlefield:setLocalVar("gameover", battlefield:getRemainingTime()) -- initiate loss condition trigger & record the time remaining
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            mob:showText(mob, ID.text.TENZEN_MSG_OFFSET +1)
        end)
    end
end

TenzenFunctions.formSwap = function(mob)
    local changeTime = mob:getLocalVar("changeTime")
    local battleTime = mob:getBattleTime()

    if mob:getLocalVar("meikyo") == 0 then
        if (mob:AnimationSub() == 0 and battleTime - changeTime > 60) then
            mob:AnimationSub(5) -- 5 lowered bow mode (1033 animation) 6 is raised bow mode (1034 animation)
            mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
            mob:SetMobSkillAttack(1171)
            mob:setLocalVar("changeTime", mob:getBattleTime())
            if mob:AnimationSub() == 5 then -- need to sheath his great katana before pulling out bow
                mob:timer(1000, function(mobArg)
                    mob:setMod(xi.mod.DELAY, 2400) -- attacks more frequently while bow is drawn
                    mob:AnimationSub(6)
                end)
            end
        elseif (mob:AnimationSub() == 6 and battleTime - changeTime > 30) then
            mob:AnimationSub(0)
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.STANDBACK)))
            mob:SetMobSkillAttack(0)
            mob:setMod(xi.mod.DELAY, 0) -- attack slower back to great katana
            mob:setLocalVar("changeTime", mob:getBattleTime())
        end
    end
end

TenzenFunctions.riceBall = function(mob, target, busyState)
    local battlefield = mob:getBattlefield()
    if mob:actionQueueEmpty() == true and not busyState then
        if mob:getHPP() <= 70 and mob:getLocalVar("riceball") == 0 then
            if battlefield:getLocalVar("fireworks") ~= 1 then
                mob:showText(target, ID.text.TENZEN_MSG_OFFSET +3)
                mob:useMobAbility(1398)
                mob:addMod(xi.mod.ATT, 50)
                mob:addMod(xi.mod.DEF, 30)
                mob:setMod(xi.mod.DOUBLE_ATTACK, 5)
                mob:addMod(xi.mod.DEX, 4)
                mob:addMod(xi.mod.VIT, 4)
                mob:addMod(xi.mod.CHR, 4)
                mob:setLocalVar("riceball", 1)
            end
        end
    end
end

return TenzenFunctions
