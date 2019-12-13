classdef DataFile < Data
    properties (Access = public)
        fileName;
        columnNames;
        data;
    end
    
    properties (Dependent)
        numRows;
        numColumns;
    end
    
    methods
        function r = get.numRows(obj)
            r = size(obj.data,1);
        end
        
        function c = get.numColumns(obj)
            c = size(obj.data,2);
        end
    end
    
    methods (Access = public)
        function obj = DataFile(fileName,data,columnNames)
            if nargin > 0
                obj.fileName = fileName;
                if nargin > 1
                    obj.data = data;
                    if nargin > 2
                        obj.columnNames = columnNames;
                    end
                end
            end
            obj.type = DataType.kDataFile;
        end
        
        %creates a table from the data contained in the DataFile instance
        function table = convertToTable(obj)
            table = array2table(obj.data);
            table.Properties.VariableNames = obj.columnNames;
        end
        
        %creates a copy of the DataFile instance that contains less columns
        function file = createFileWithColumnIndices(obj,columnIndices)
            file = DataFile(obj.fileName,obj.data(:,columnIndices),obj.columnNames(columnIndices));
        end
        
        function rawData = rawDataForRowsAndColumns(obj,startRow,endRow,columns)
            rawData = obj.data(startRow:endRow,columns);
        end
    end
end