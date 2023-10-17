"""
FunctionBlocks
"""

export CompareToZeroBlock

#mutable struct CompareToZeroBlock <: AbstractBlock
#    inport::Vector{InPort}
#    outport::Vector{OutPort}

#    function CompareToZeroBlock
#        @createblock new(Vector{InPort}(), Vector{OutPort}()) 1 1
#    end
#end


mutable struct CompareToZeroBlock <: AbstractBlock
    inport::Vector{InPort}
    outport::Vector{OutPort}

    function CompareToZeroBlock()
        @createblock new(Vector{InPort}(), Vector{OutPort}()) 1 1
    end
end



"""
IO
"""

function Base.show(io::IO, blk::CompareToZeroBlock)
    println(io, "CompareToZero()")
end

"""
to expr
"""

function _toexpr(blk::CompareToZeroBlock)
    #inputvalue = _toexpr(blk.inport[1])
    
    #出力は、比較が false の場合は 0 であり、true の場合は 1
    
    Expr(:if, Expr(:comparison, 0, :>=, _toexpr(blk.inport[1])), 0, Expr(:if, Expr(:comparison, 0, :<=, _toexpr(blk.inport[1])), 1, _toexpr(blk.inport[1])))

    #Expr(:if, Expr(:comparison, upperlimit, :<=, _toexpr(blk.inport[1])), upperlimit, _toexpr(blk.inport[1]))
    
end

