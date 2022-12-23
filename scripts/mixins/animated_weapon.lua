-- Animated Weapon (Dynamis) mixin

require("scripts/globals/mixins")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.animated_weapon = function(weaponMob, options)
    weaponMob:addListener("ENGAGE", "ENGAGE_ANIMATED", function(mob, target)
        if mob:getAnimationSub() == 3 then
            mob:setLocalVar("shouldDropItem", 1)
        end
    end)

    weaponMob:addListener("ITEM_DROPS", "ITEM_DROPS_ANIMATED", function(mob, loot)
        if mob:getLocalVar("shouldDropItem") == 1 then
            loot:addItem(options.item, xi.loot.rate.GUARANTEED)
        end
    end)
end

return g_mixins.families.animated_weapon
