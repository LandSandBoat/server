-----------------------------------
-- Guild Master Rank Cap (Removes the prompt for players to go past Veteran Rank)
-----------------------------------
require('modules/module_utils')
require('scripts/globals/hobbies/crafting/guild_master')
-----------------------------------
local m = Module:new('guild_master_rank_cap')

local function setVeteranAsTopRank(func, player, npc, trade)
    local getCraftSkillCap = xi.crafting.getCraftSkillCap

    xi.crafting.getCraftSkillCap = function(target, skillId)
        if target:getSkillRank(skillId) >= xi.craftRank.VETERAN then
            return 110
        end

        return getCraftSkillCap(target, skillId)
    end

    func(player, npc, trade)

    xi.crafting.getCraftSkillCap = getCraftSkillCap
end

m:addOverride('xi.crafting.guildMasterOnTrigger', function(player, npc)
    setVeteranAsTopRank(super, player, npc)
end)

m:addOverride('xi.crafting.guildMasterOnTrade', function(player, npc, trade)
    setVeteranAsTopRank(super, player, npc, trade)
end)

return m
