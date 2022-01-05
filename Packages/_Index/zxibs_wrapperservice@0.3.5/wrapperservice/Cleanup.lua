local WrapperService = require(script.Parent)
local t = require(script.Parent.Parent:WaitForChild("t"))

local cleanupCheck = t.tuple(WrapperService.isWrapped)

local function ClearTableDescendants(tableToClear)
	for index, value in pairs(tableToClear) do
		if typeof(value) == "table" then
			table.clear(tableToClear[index])
			setmetatable(tableToClear[index], nil)
			ClearTableDescendants(tableToClear[index])
		end
	end
end

local function Cleanup(self)
	assert(cleanupCheck(self))

	local instance = self.Instance
	WrapperService.__wrappedInstances[self.__id] = nil
	ClearTableDescendants(self)
	setmetatable(self, nil)
	table.clear(self)

	return instance
end

return Cleanup