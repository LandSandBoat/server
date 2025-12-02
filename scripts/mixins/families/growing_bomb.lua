-- Description: Handles the growth and skill selection of growing bombs. (Big Bombs, Friar Lanterns)
-- Behavior: These bombs will expand in size after taking a spike in damage. (Observed 280 or higher in a single hit)
-- As they grow, their stats increase slightly (Attack, Magic Attack, Enspell Damage Bonus). -- TODO: Capture exact values, currently approximated based on 2 days of testing.
-- They also gain access to more powerful skills. At their largest size, Friars Lanterns gain access to Self-Destruct.
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.growingBomb = xi.mix.growingBomb or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

xi.mix.growingBomb.onMobMobskillChoose = function(mob, target)
    local animation = mob:getAnimationSub()
    local skillList = {}

    switch(animation): caseof
    {
        [0] = function() -- Small
            table.insert(skillList, xi.mobSkill.BERSERK_BOMB_BIG)
            table.insert(skillList, xi.mobSkill.VULCANIAN_IMPACT)
        end,

        [1] = function() -- Medium
            table.insert(skillList, xi.mobSkill.VULCANIAN_IMPACT)
            table.insert(skillList, xi.mobSkill.HELLSTORM)
        end,

        [2] = function() -- Large
            table.insert(skillList, xi.mobSkill.HELLSTORM)
            table.insert(skillList, xi.mobSkill.HEAT_WAVE)
        end,

        [3] = function() -- Giant
            table.insert(skillList, xi.mobSkill.HELLSTORM)
            table.insert(skillList, xi.mobSkill.HEAT_WAVE)

            -- If the mob is NOT a notorious monster, it can use Self-Destruct (Friars Lantern)
            if not mob:isMobType(xi.mobType.NOTORIOUS) then
                table.insert(skillList, xi.mobSkill.SELF_DESTRUCT_BOMB_BIG)
            end
        end,
    }

    return skillList[math.random(1, #skillList)]
end

g_mixins.families.growing_bomb = function(bombMob)
    bombMob:addListener('TAKE_DAMAGE', 'BOMB_GROW_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        local animation = mobArg:getAnimationSub()
        local currentTime       = GetSystemTime()
        local nextChange = mobArg:getLocalVar('BOMB_GROW_NEXT_CHANGE')

        if
            damage > 280 and
            animation < 3 and
            (nextChange == 0 or currentTime >= nextChange)
        then
            mobArg:setLocalVar('BOMB_GROW_NEXT_CHANGE', currentTime + 5) -- 5 second cooldown between growths
            mobArg:addMod(xi.mod.ATT, 50) -- Approximate values based on some testing, needs more precise capturing
            mobArg:addMod(xi.mod.MATT, 35) -- Observed significantly stronger magic damage at larger sizes
            mobArg:addMod(xi.mod.ENSPELL_DMG_BONUS, 15) -- Observed 60-65 enfire damage at giant size

            -- Bomb doesn't grow immediately and instead queues the action
            mobArg:queue(0, function(m)
                m:setAnimationSub(animation + 1)
            end)
        end
    end)

    -- Shrinks back down on death TODO: Animation doesn't play quite as smoothly on LSB, may be packet related. Retail Behavior: https://youtu.be/mX5zA6OT5Ao?si=pXbBVcICNdlsadx8&t=90
    bombMob:addListener('DEATH', 'BOMB_GROW_DEATH', function(mobArg)
        -- I believe animationSub(4) is the death animation, not animationSub(0)
        mobArg:setAnimationSub(4)
        mobArg:setLocalVar('BOMB_GROW_NEXT_CHANGE', 0)
    end)
end

return g_mixins.families.growing_bomb
