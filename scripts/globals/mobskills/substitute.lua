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
-----------------------------------
local mobskillObject = {}

local resistances =
{
    xi.mod.SLASH_SDT,
    xi.mod.PIERCE_SDT,
    xi.mod.IMPACT_SDT,
    xi.mod.HTH_SDT,
}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Marquis Andrealphus
    if mob:getPool() == 2571 then
        local party = target:getParty()
        local control = false

        -- Ability is only used when there is another party
        -- member in the party, or party size > 1
        if mob:getPool() == 2571 then
            if #party > 1 then
                for _, v in ipairs(target:getParty()) do
                    if v:getZone() == target:getZone() then
                        control = true
                    end
                end
            else
                control = true
            end
        end

        if control then
            mob:timer(1000, function(mobArg)
                mobArg:injectActionPacket(target:getID(), 4, 261, 0, 0, 0, 10, 1)
                mobArg:timer(3000, function(mobArg1)
                    xi.teleport.escape(target)
                end)
            end)
        end

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

    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskillObject
