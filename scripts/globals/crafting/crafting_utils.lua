-----------------------------------
-- Crafting utility functions
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.crafting = xi.crafting or {}
-----------------------------------
xi.crafting.guildTable =
{
    --           [guild ID] = { skill used,            'currency used'      },
    [xi.guild.FISHING     ] = { xi.skill.FISHING,      'guild_fishing'      },
    [xi.guild.WOODWORKING ] = { xi.skill.WOODWORKING,  'guild_woodworking'  },
    [xi.guild.SMITHING    ] = { xi.skill.SMITHING,     'guild_smithing'     },
    [xi.guild.GOLDSMITHING] = { xi.skill.GOLDSMITHING, 'guild_goldsmithing' },
    [xi.guild.CLOTHCRAFT  ] = { xi.skill.CLOTHCRAFT,   'guild_weaving'      },
    [xi.guild.LEATHERCRAFT] = { xi.skill.LEATHERCRAFT, 'guild_leathercraft' },
    [xi.guild.BONECRAFT   ] = { xi.skill.BONECRAFT,    'guild_bonecraft'    },
    [xi.guild.ALCHEMY     ] = { xi.skill.ALCHEMY,      'guild_alchemy'      },
    [xi.guild.COOKING     ] = { xi.skill.COOKING,      'guild_cooking'      },
}

xi.crafting.hasJoinedGuild = function(player, guildId)
    local joinedGuildMask = player:getCharVar('Guild_Member')

    return utils.mask.getBit(joinedGuildMask, guildId)
end

xi.crafting.getCraftSkillCap = function(player, skillId)
    local rank = player:getSkillRank(skillId)

    return (rank + 1) * 10
end

xi.crafting.getRealSkill = function(player, skillId)
    return math.floor(player:getCharSkillLevel(skillId) / 10)
end
