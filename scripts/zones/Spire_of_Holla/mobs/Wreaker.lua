-----------------------------------
-- Area: Spire of Holla
--  Mob: Wreaker
-----------------------------------
mixins = { require("scripts/mixins/families/empty_terroanima") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:addMod(xi.mod.DEFP,35)
    mob:setMod(xi.mod.STORETP, 100)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local roll = math.random()
    if mob:getHPP() <= 25 then
        if roll <= 0.25 then
            return 1252 -- Shadow_spread
        else
            return 1248 -- Trinary_absorption
        end
    end
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 35 then
        mob:setMod(xi.mod.STORETP, 250)
    end
end

return entity
