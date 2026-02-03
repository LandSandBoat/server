-----------------------------------
--- Soulflayer Family Mixin
--  https://ffxiclopedia.fandom.com/wiki/Category:Soulflayers
--  https://www.bg-wiki.com/ffxi/Category:Soulflayers
--
--  Soulflayers animate a stacking floating orb around them after using Immortal Shield
--
--  Animation Sub 0 No shield active
--  Animation Sub 1 One Floating Orb (1 stack of Immortal Shield)
--  Animation Sub 2 Two Floating Orbs (2 stacks of Immortal Shield)
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.soulflayer = function(soulflayerMob)
    soulflayerMob:addListener('SPAWN', 'SOULFLAYER_SPAWN', function(mob)
        -- Apply family wide bonuses
        mob:setAnimationSub(0)
        mob:setMod(xi.mod.DEFP, 20)
        mob:setMod(xi.mod.MDEF, 120)
        mob:setMod(xi.mod.MATT, 30)
        mob:setMod(xi.mod.UDMGBREATH, -2500)
        mob:setMod(xi.mod.UDMGMAGIC, -2500)
    end)

    soulflayerMob:addListener('COMBAT_TICK', 'SOULFLAYER_COMBAT_TICK', function(mob)
        local shieldStacks = mob:getLocalVar('immortalShieldStacks')

        if shieldStacks > 0 then
            local remainingStoneskin = mob:getMod(xi.mod.STONESKIN)

            -- If 2 stacks and stoneskin dropped below 1000, reduce to 1 stack
            if shieldStacks == 2 and remainingStoneskin < 1000 then
                mob:setLocalVar('immortalShieldStacks', 1)
                mob:setAnimationSub(1)
            elseif remainingStoneskin <= 0 then
                mob:setLocalVar('immortalShieldStacks', 0)
                mob:setAnimationSub(0)
            end
        end
    end)
end

return g_mixins.families.soulflayer
