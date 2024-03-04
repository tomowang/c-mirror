local ctx = ngx.ctx
if ctx.buffers == nil then
  ctx.buffers = {}
  ctx.nbuffers = 0
end

local data = ngx.arg[1]
local eof = ngx.arg[2]
local next_idx = ctx.nbuffers + 1
local original_str = "https://civitai.com/api/download/models/(%d+)"
local replacement = "https://c-mirror.com/api/download/models/%1"

if not eof then
  if data then
    ctx.buffers[next_idx] = data
    ctx.nbuffers = next_idx
    -- Send nothing to the client yet.
    ngx.arg[1] = nil
  end
  return
elseif data then
  ctx.buffers[next_idx] = data
  ctx.nbuffers = next_idx
end

-- Yes, we have read the full body.
-- Make sure it is stored in our buffer.
assert(ctx.buffers)
assert(ctx.nbuffers ~= 0, "buffer must not be empty")

-- And send a new body
ngx.arg[1] = string.gsub(table.concat(ngx.ctx.buffers), original_str, replacement)
