-----------------------------------
-- Substitute
-- Dummy ability used several mobs.
--
-- Marquis Andrealphus:
--  Uses this ability to warp target player
--  out of the zone
--
-- BCNM: Die by the Sword
--  Mobs use this ability to switch animation
--  ID as well as physical resistances
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

local resistances =
{
    xi.mod.SLASH_SDT,
    xi.mod.PIERCE_SDT,
    xi.mod.IMPACT_SDT,
    xi.mod.HTH_SDT,
}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    -- Marquis Andrealphus
    if mob:getPool() == 2571 then
        if #target:getParty() == 1 then
            return 1
        end
    end
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    -- Marquis Andrealphus
    if mob:getPool() == 2571 then
        mob:timer(2000, function(mobArg)
            xi.teleport.escape(target)
        end)

    -- Die by the Sword BCNM
    else
        local oldAnim = mob:getAnimationSub()
        local newAnim = oldAnim

        while newAnim == oldAnim do
            newAnim = math.random(1,3)
        end

        mob:setAnimationSub(newAnim)

        for i = 1, 4 do
            if i == newAnim then
                mob:setMod(resistances[i], 1000)
            else
                mob:setMod(resistances[i], -2500)
            end
        end

        if newAnim == 3 then
            mob:setMod(resistances[4], 1000)
        else
            mob:setMod(resistances[4], -2500)
        end

        skill:setMsg(xi.msg.basic.NONE)
        return 0
    end
end

return mobskill_object
