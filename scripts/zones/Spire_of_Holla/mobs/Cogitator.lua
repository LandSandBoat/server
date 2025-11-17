-----------------------------------
-- Area: Spire of Holla
--  Mob: Cogitator
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMod(xi.mod.REGAIN, 150)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local skills =
    {
        xi.mobSkill.NEGATIVE_WHIRL_1,
        xi.mobSkill.STYGIAN_VAPOR,
        xi.mobSkill.WINDS_OF_PROMYVION_1,
        xi.mobSkill.SHADOW_SPREAD,
        xi.mobSkill.EMPTY_CUTTER
    }

    if math.random(1, 100) <= 50 then
        return xi.mobSkill.TRINARY_TAP
    else
        return skills[math.random(1, #skills)]
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == xi.mobSkill.TRINARY_TAP then
        mob:useMobAbility(xi.mobSkill.TRINARY_ABSORPTION)
    end

    if skill:getID() == xi.mobSkill.TRINARY_ABSORPTION then
        local cogitatorID = mob:getID()
        local pets = { cogitatorID + 1, cogitatorID + 2, cogitatorID + 3 }
        local petParams =
        {
            maxSpawns = 1,
            noAnimation = true,
            dieWithOwner = true,
            superlink = true,
            ignoreBusy = true,
        }
        xi.mob.callPets(mob, pets, petParams)
    end
end

return entity
