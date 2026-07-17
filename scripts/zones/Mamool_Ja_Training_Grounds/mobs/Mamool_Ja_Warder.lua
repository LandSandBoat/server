-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  MOB: Mamool Ja Warder
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }

local warder    = require('scripts/zones/Mamool_Ja_Training_Grounds/globals/warder')
local bstWarder = require('scripts/zones/Mamool_Ja_Training_Grounds/mobs/Mamool_Ja_Warder_bst')
local ninWarder = require('scripts/zones/Mamool_Ja_Training_Grounds/mobs/Mamool_Ja_Warder_nin')
local whmWarder = require('scripts/zones/Mamool_Ja_Training_Grounds/mobs/Mamool_Ja_Warder_whm')
-----------------------------------
---@type TMobEntity
local entity = {}

local jobScripts =
{
    [xi.job.BST] = bstWarder,
    [xi.job.NIN] = ninWarder,
    [xi.job.WHM] = whmWarder,
}

local function getJobScript(mob)
    return jobScripts[mob:getMainJob()]
end

entity.onMobSpawn = function(mob)
    warder.onMobSpawn(mob)

    local jobScript = getJobScript(mob)
    if jobScript and jobScript.onMobSpawn then
        jobScript.onMobSpawn(mob)
    end
end

entity.onMobFight = function(mob, target)
    local jobScript = getJobScript(mob)
    if jobScript and jobScript.onMobFight then
        jobScript.onMobFight(mob, target)
    end
end

entity.onMobRoam = function(mob)
    local jobScript = getJobScript(mob)
    if jobScript and jobScript.onMobRoam then
        jobScript.onMobRoam(mob)
    end
end

entity.onMobWeaponSkill = warder.onMobWeaponSkill

return entity
