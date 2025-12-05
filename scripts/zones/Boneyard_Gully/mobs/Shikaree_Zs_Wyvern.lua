-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree Z's Wyvern
-----------------------------------
---@type TMobEntity
local entity = {}

-- Status removal breath table (mimics player wyvern behavior)
local removeBreathTable =
{
    [xi.effect.PARALYSIS] = xi.mobSkill.REMOVE_PARALYSIS,
    [xi.effect.BLINDNESS] = xi.mobSkill.REMOVE_BLINDNESS,
    [xi.effect.POISON   ] = xi.mobSkill.REMOVE_POISON,
}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 70)
end

entity.onMobMobskillChoose = function(mob, target)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return 0
    end

    local breathRange   = 14
    local healThreshold = 90 -- Use healing breath when ally is below 90% HP

    -- First priority: Check for status effects to remove
    local allies        = battlefield:getMobs(true, true)
    for _, ally in pairs(allies) do
        if ally:isAlive() then
            local distance = mob:checkDistance(ally)
            if distance <= breathRange then
                for effect, ability in pairs(removeBreathTable) do
                    if ally:hasStatusEffect(effect) then
                        mob:setLocalVar('healTargetID', ally:getID())
                        return ability
                    end
                end
            end
        end
    end

    -- Second priority: Healing breath for low HP allies (including self)
    local lowestAlly = 0
    local lowestHPP  = 100

    for _, ally in pairs(allies) do
        if ally:isAlive() then
            local distance = mob:checkDistance(ally)
            if distance <= breathRange then
                local hpp = ally:getHPP()
                if hpp <= healThreshold and hpp < lowestHPP then
                    lowestAlly = ally:getID()
                    lowestHPP = hpp
                end
            end
        end
    end

    if lowestAlly > 0 then
        mob:setLocalVar('healTargetID', lowestAlly)
        return xi.mobSkill.HEALING_BREATH_III
    end

    -- No support needed, use random offensive breath
    mob:setLocalVar('healTargetID', 0)
    local tpSkills =
    {
        xi.mobSkill.PET_FLAME_BREATH,
        xi.mobSkill.PET_FROST_BREATH,
        xi.mobSkill.PET_GUST_BREATH,
        xi.mobSkill.PET_SAND_BREATH,
        xi.mobSkill.PET_LIGHTNING_BREATH,
        xi.mobSkill.PET_HYDRO_BREATH,
    }

    return tpSkills[math.random(1, #tpSkills)]
end

entity.onMobSkillTarget = function(target, mob, skill)
    -- Redirect supportive breaths to the appropriate ally
    local healTargetID = mob:getLocalVar('healTargetID')
    local skillID = skill:getID()

    -- Check if this is a supportive breath (healing or status removal)
    local supportiveBreaths =
    {
        xi.mobSkill.HEALING_BREATH_III,
        xi.mobSkill.REMOVE_PARALYSIS,
        xi.mobSkill.REMOVE_BLINDNESS,
        xi.mobSkill.REMOVE_POISON,
    }

    for _, supportiveSkill in pairs(supportiveBreaths) do
        if skillID == supportiveSkill and healTargetID > 0 then
            local healTarget = GetMobByID(healTargetID)
            if healTarget and healTarget:isAlive() then
                return healTarget
            end
        end
    end

    return target
end

return entity
