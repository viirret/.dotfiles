-- cmp keys
local M = {}

function M.get_mappings()
	local cmp = require("cmp")
	local cmp_select = { behavior = cmp.SelectBehavior.Select }

	return cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	})
end

return M
