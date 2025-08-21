-- Description:
-- This mixin applies to both the NM: Big Bomb, as well as the Friar's Lantern bombs that
-- drop the smoke-filled flask in Halvung.

-- Behavior:
-- These bombs will expand in size after taking a spike in damage of a recorded value exceeding 300. They evidently
-- increase in attack and magic power.
-- Note:
-- These values are a close approximation and are therefore ***experimental*** they require further captures and balancing.
require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.bomb_grow = function(bombMob)
    bombMob:addListener('TAKE_DAMAGE', 'BOMB_GROW_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
        local anim = mobArg:getAnimationSub()

        if
            damage > 300 and
            anim < 2
        then
            mobArg:addMod(xi.mod.ATT, 75) -- **EXPERIMENTAL**
            mobArg:addMod(xi.mod.MATT, 75) -- **EXPERIMENTAL**
            -- Bomb doesn't grow immediately and instead queues the action
            mobArg:queue(0, function(mobArg1)
                mobArg1:setAnimationSub(anim + 1)
            end)
        end
    end)

    -- Shrinks back down on death
    bombMob:addListener('DEATH', 'BOMB_GROW_DEATH', function(mobArg)
        mobArg:setAnimationSub(0)
    end)
end

return g_mixins.families.bomb_grow
