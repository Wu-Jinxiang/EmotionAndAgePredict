node {
  name: "batch_processing/input_producer/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 10
          }
        }
        string_val: "..\\AgeGenderDeepLearning-master\\Folds\\tf\\gender_test_fold_is_0\\train-00000-of-00010"
        string_val: "..\\AgeGenderDeepLearning-master\\Folds\\tf\\gender_test_fold_is_0\\train-00001-of-00010"
        string_val: "..\\AgeGenderDeepLearning-master\\Folds\\tf\\gender_test_fold_is_0\\train-00002-of-00010"
        string_val: "..\\AgeGenderDeepLearning-master\\Folds\\tf\\gender_test_fold_is_0\\train-00003-of-00010"
        string_val: "..\\AgeGenderDeepLearning-master\\Folds\\tf\\gender_test_fold_is_0\\train-00004-of-00010"
        string_val: "..\\AgeGenderDeepLearning-master\\Folds\\tf\\gender_test_fold_is_0\\train-00005-of-00010"
        string_val: "..\\AgeGenderDeepLearning-master\\Folds\\tf\\gender_test_fold_is_0\\train-00006-of-00010"
        string_val: "..\\AgeGenderDeepLearning-master\\Folds\\tf\\gender_test_fold_is_0\\train-00007-of-00010"
        string_val: "..\\AgeGenderDeepLearning-master\\Folds\\tf\\gender_test_fold_is_0\\train-00008-of-00010"
        string_val: "..\\AgeGenderDeepLearning-master\\Folds\\tf\\gender_test_fold_is_0\\train-00009-of-00010"
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/Size"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 10
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/Greater/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/Greater"
  op: "Greater"
  input: "batch_processing/input_producer/Size"
  input: "batch_processing/input_producer/Greater/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/input_producer/Assert/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "string_input_producer requires a non-null input tensor"
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/Assert/Assert/data_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "string_input_producer requires a non-null input tensor"
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/Assert/Assert"
  op: "Assert"
  input: "batch_processing/input_producer/Greater"
  input: "batch_processing/input_producer/Assert/Assert/data_0"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 3
    }
  }
}
node {
  name: "batch_processing/input_producer/Identity"
  op: "Identity"
  input: "batch_processing/input_producer/Const"
  input: "^batch_processing/input_producer/Assert/Assert"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
}
node {
  name: "batch_processing/input_producer/RandomShuffle"
  op: "RandomShuffle"
  input: "batch_processing/input_producer/Identity"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/input_producer"
  op: "FIFOQueueV2"
  device: "/device:CPU:0"
  attr {
    key: "capacity"
    value {
      i: 16
    }
  }
  attr {
    key: "component_types"
    value {
      list {
        type: DT_STRING
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "shapes"
    value {
      list {
        shape {
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "batch_processing/input_producer/input_producer_EnqueueMany"
  op: "QueueEnqueueManyV2"
  input: "batch_processing/input_producer"
  input: "batch_processing/input_producer/RandomShuffle"
  device: "/device:CPU:0"
  attr {
    key: "Tcomponents"
    value {
      list {
        type: DT_STRING
      }
    }
  }
  attr {
    key: "timeout_ms"
    value {
      i: -1
    }
  }
}
node {
  name: "batch_processing/input_producer/input_producer_Close"
  op: "QueueCloseV2"
  input: "batch_processing/input_producer"
  device: "/device:CPU:0"
  attr {
    key: "cancel_pending_enqueues"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/input_producer/input_producer_Close_1"
  op: "QueueCloseV2"
  input: "batch_processing/input_producer"
  device: "/device:CPU:0"
  attr {
    key: "cancel_pending_enqueues"
    value {
      b: true
    }
  }
}
node {
  name: "batch_processing/input_producer/input_producer_Size"
  op: "QueueSizeV2"
  input: "batch_processing/input_producer"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/input_producer/ToFloat"
  op: "Cast"
  input: "batch_processing/input_producer/input_producer_Size"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/input_producer/mul/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0625
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/mul"
  op: "Mul"
  input: "batch_processing/input_producer/ToFloat"
  input: "batch_processing/input_producer/mul/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/input_producer/fraction_of_16_full/tags"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "batch_processing/input_producer/fraction_of_16_full"
      }
    }
  }
}
node {
  name: "batch_processing/input_producer/fraction_of_16_full"
  op: "ScalarSummary"
  input: "batch_processing/input_producer/fraction_of_16_full/tags"
  input: "batch_processing/input_producer/mul"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_shuffle_queue"
  op: "RandomShuffleQueueV2"
  device: "/device:CPU:0"
  attr {
    key: "capacity"
    value {
      i: 17152
    }
  }
  attr {
    key: "component_types"
    value {
      list {
        type: DT_STRING
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "min_after_dequeue"
    value {
      i: 16384
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
  attr {
    key: "shapes"
    value {
      list {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "batch_processing/TFRecordReaderV2"
  op: "TFRecordReaderV2"
  device: "/device:CPU:0"
  attr {
    key: "compression_type"
    value {
      s: ""
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "batch_processing/ReaderReadV2"
  op: "ReaderReadV2"
  input: "batch_processing/TFRecordReaderV2"
  input: "batch_processing/input_producer"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/ParseSingleExample/key_image/class/label"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Reshape/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Reshape"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample/key_image/class/label"
  input: "batch_processing/ParseSingleExample/Reshape/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/key_image/class/text"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Reshape_1/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Reshape_1"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample/key_image/class/text"
  input: "batch_processing/ParseSingleExample/Reshape_1/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/key_image/encoded"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Reshape_2/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Reshape_2"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample/key_image/encoded"
  input: "batch_processing/ParseSingleExample/Reshape_2/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/key_image/filename"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Reshape_3/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Reshape_3"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample/key_image/filename"
  input: "batch_processing/ParseSingleExample/Reshape_3/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/key_image/height"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Reshape_4/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Reshape_4"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample/key_image/height"
  input: "batch_processing/ParseSingleExample/Reshape_4/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/key_image/width"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Reshape_5/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/Reshape_5"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample/key_image/width"
  input: "batch_processing/ParseSingleExample/Reshape_5/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample/ParseSingleExample"
  op: "ParseSingleExample"
  input: "batch_processing/ReaderReadV2:1"
  input: "batch_processing/ParseSingleExample/Reshape"
  input: "batch_processing/ParseSingleExample/Reshape_1"
  input: "batch_processing/ParseSingleExample/Reshape_2"
  input: "batch_processing/ParseSingleExample/Reshape_3"
  input: "batch_processing/ParseSingleExample/Reshape_4"
  input: "batch_processing/ParseSingleExample/Reshape_5"
  device: "/device:CPU:0"
  attr {
    key: "Tdense"
    value {
      list {
        type: DT_INT64
        type: DT_STRING
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
        type: DT_INT64
      }
    }
  }
  attr {
    key: "dense_keys"
    value {
      list {
        s: "image/class/label"
        s: "image/class/text"
        s: "image/encoded"
        s: "image/filename"
        s: "image/height"
        s: "image/width"
      }
    }
  }
  attr {
    key: "dense_shapes"
    value {
      list {
        shape {
          dim {
            size: 1
          }
        }
        shape {
        }
        shape {
        }
        shape {
        }
        shape {
          dim {
            size: 1
          }
        }
        shape {
          dim {
            size: 1
          }
        }
      }
    }
  }
  attr {
    key: "num_sparse"
    value {
      i: 0
    }
  }
  attr {
    key: "sparse_keys"
    value {
      list {
      }
    }
  }
  attr {
    key: "sparse_types"
    value {
      list {
      }
    }
  }
}
node {
  name: "batch_processing/Cast"
  op: "Cast"
  input: "batch_processing/ParseSingleExample/ParseSingleExample"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg/DecodeJpeg"
  op: "DecodeJpeg"
  input: "batch_processing/ParseSingleExample/ParseSingleExample:2"
  device: "/device:CPU:0"
  attr {
    key: "acceptable_fraction"
    value {
      f: 1.0
    }
  }
  attr {
    key: "channels"
    value {
      i: 3
    }
  }
  attr {
    key: "dct_method"
    value {
      s: ""
    }
  }
  attr {
    key: "fancy_upscaling"
    value {
      b: true
    }
  }
  attr {
    key: "ratio"
    value {
      i: 1
    }
  }
  attr {
    key: "try_recover_truncated"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg/convert_image/Cast"
  op: "Cast"
  input: "batch_processing/decode_jpeg/DecodeJpeg"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_UINT8
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg/convert_image/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.003921568859368563
      }
    }
  }
}
node {
  name: "batch_processing/decode_jpeg/convert_image"
  op: "Mul"
  input: "batch_processing/decode_jpeg/convert_image/Cast"
  input: "batch_processing/decode_jpeg/convert_image/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_crop/size"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/Shape"
  op: "Shape"
  input: "batch_processing/decode_jpeg/convert_image"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop/GreaterEqual"
  op: "GreaterEqual"
  input: "batch_processing/random_crop/Shape"
  input: "batch_processing/random_crop/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/All"
  op: "All"
  input: "batch_processing/random_crop/GreaterEqual"
  input: "batch_processing/random_crop/Const"
  device: "/device:CPU:0"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/random_crop/Assert/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/Assert/Assert/data_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/Assert/Assert"
  op: "Assert"
  input: "batch_processing/random_crop/All"
  input: "batch_processing/random_crop/Assert/Assert/data_0"
  input: "batch_processing/random_crop/Shape"
  input: "batch_processing/random_crop/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_INT32
        type: DT_INT32
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 1000
    }
  }
}
node {
  name: "batch_processing/random_crop/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop/Shape"
  input: "^batch_processing/random_crop/Assert/Assert"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop/Shape"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/sub"
  op: "Sub"
  input: "batch_processing/random_crop/control_dependency"
  input: "batch_processing/random_crop/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop/add/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/add"
  op: "Add"
  input: "batch_processing/random_crop/sub"
  input: "batch_processing/random_crop/add/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop/Shape_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2147483647
      }
    }
  }
}
node {
  name: "batch_processing/random_crop/random_uniform"
  op: "RandomUniformInt"
  input: "batch_processing/random_crop/Shape_1"
  input: "batch_processing/random_crop/random_uniform/min"
  input: "batch_processing/random_crop/random_uniform/max"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tout"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_crop/mod"
  op: "FloorMod"
  input: "batch_processing/random_crop/random_uniform"
  input: "batch_processing/random_crop/add"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop"
  op: "Slice"
  input: "batch_processing/decode_jpeg/convert_image"
  input: "batch_processing/random_crop/mod"
  input: "batch_processing/random_crop/size"
  device: "/device:CPU:0"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop"
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/random_uniform/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_flip_left_right/random_uniform/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/random_uniform/sub"
  op: "Sub"
  input: "batch_processing/random_flip_left_right/random_uniform/max"
  input: "batch_processing/random_flip_left_right/random_uniform/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/random_uniform/mul"
  op: "Mul"
  input: "batch_processing/random_flip_left_right/random_uniform/RandomUniform"
  input: "batch_processing/random_flip_left_right/random_uniform/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/random_uniform"
  op: "Add"
  input: "batch_processing/random_flip_left_right/random_uniform/mul"
  input: "batch_processing/random_flip_left_right/random_uniform/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/Less/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.5
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/Less"
  op: "Less"
  input: "batch_processing/random_flip_left_right/random_uniform"
  input: "batch_processing/random_flip_left_right/Less/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/Switch"
  op: "Switch"
  input: "batch_processing/random_flip_left_right/Less"
  input: "batch_processing/random_flip_left_right/Less"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/switch_t"
  op: "Identity"
  input: "batch_processing/random_flip_left_right/Switch:1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/switch_f"
  op: "Identity"
  input: "batch_processing/random_flip_left_right/Switch"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/pred_id"
  op: "Identity"
  input: "batch_processing/random_flip_left_right/Less"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/ReverseV2/axis"
  op: "Const"
  input: "^batch_processing/random_flip_left_right/switch_t"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/ReverseV2"
  op: "ReverseV2"
  input: "batch_processing/random_flip_left_right/ReverseV2/Switch:1"
  input: "batch_processing/random_flip_left_right/ReverseV2/axis"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/ReverseV2/Switch"
  op: "Switch"
  input: "batch_processing/random_flip_left_right/control_dependency"
  input: "batch_processing/random_flip_left_right/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop"
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/Switch_1"
  op: "Switch"
  input: "batch_processing/random_flip_left_right/control_dependency"
  input: "batch_processing/random_flip_left_right/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop"
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right/Merge"
  op: "Merge"
  input: "batch_processing/random_flip_left_right/Switch_1"
  input: "batch_processing/random_flip_left_right/ReverseV2"
  device: "/device:CPU:0"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform/sub"
  op: "Sub"
  input: "batch_processing/random_uniform/max"
  input: "batch_processing/random_uniform/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform/mul"
  op: "Mul"
  input: "batch_processing/random_uniform/RandomUniform"
  input: "batch_processing/random_uniform/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform"
  op: "Add"
  input: "batch_processing/random_uniform/mul"
  input: "batch_processing/random_uniform/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness/Identity"
  op: "Identity"
  input: "batch_processing/random_flip_left_right/Merge"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness"
  op: "Add"
  input: "batch_processing/adjust_brightness/Identity"
  input: "batch_processing/random_uniform"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_brightness"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_1/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_1/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.20000000298023224
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_1/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.7999999523162842
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_1/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_1/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_1/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_1/max"
  input: "batch_processing/random_uniform_1/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_1/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_1/RandomUniform"
  input: "batch_processing/random_uniform_1/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_1"
  op: "Add"
  input: "batch_processing/random_uniform_1/mul"
  input: "batch_processing/random_uniform_1/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast/Identity"
  op: "Identity"
  input: "batch_processing/adjust_brightness/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast"
  op: "AdjustContrastv2"
  input: "batch_processing/adjust_contrast/Identity"
  input: "batch_processing/random_uniform_1"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/adjust_contrast/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_contrast"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/control_dependency"
  op: "Identity"
  input: "batch_processing/adjust_contrast/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/adjust_contrast/Identity_1"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/strided_slice/stack"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: -3
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/strided_slice/stack_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/strided_slice/stack_2"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/strided_slice"
  op: "StridedSlice"
  input: "batch_processing/per_image_standardization/Shape"
  input: "batch_processing/per_image_standardization/strided_slice/stack"
  input: "batch_processing/per_image_standardization/strided_slice/stack_1"
  input: "batch_processing/per_image_standardization/strided_slice/stack_2"
  device: "/device:CPU:0"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 1
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Prod"
  op: "Prod"
  input: "batch_processing/per_image_standardization/strided_slice"
  input: "batch_processing/per_image_standardization/Const"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Mean/reduction_indices"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\377\377\377\377\376\377\377\377\375\377\377\377"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Mean"
  op: "Mean"
  input: "batch_processing/per_image_standardization/control_dependency"
  input: "batch_processing/per_image_standardization/Mean/reduction_indices"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Square"
  op: "Square"
  input: "batch_processing/per_image_standardization/control_dependency"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Mean_1/reduction_indices"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\377\377\377\377\376\377\377\377\375\377\377\377"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Mean_1"
  op: "Mean"
  input: "batch_processing/per_image_standardization/Square"
  input: "batch_processing/per_image_standardization/Mean_1/reduction_indices"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Square_1"
  op: "Square"
  input: "batch_processing/per_image_standardization/Mean"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/sub"
  op: "Sub"
  input: "batch_processing/per_image_standardization/Mean_1"
  input: "batch_processing/per_image_standardization/Square_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Relu"
  op: "Relu"
  input: "batch_processing/per_image_standardization/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Sqrt"
  op: "Sqrt"
  input: "batch_processing/per_image_standardization/Relu"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Cast"
  op: "Cast"
  input: "batch_processing/per_image_standardization/Prod"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Rsqrt"
  op: "Rsqrt"
  input: "batch_processing/per_image_standardization/Cast"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Maximum"
  op: "Maximum"
  input: "batch_processing/per_image_standardization/Sqrt"
  input: "batch_processing/per_image_standardization/Rsqrt"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization/Sub_1"
  op: "Sub"
  input: "batch_processing/per_image_standardization/control_dependency"
  input: "batch_processing/per_image_standardization/Mean"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization"
  op: "RealDiv"
  input: "batch_processing/per_image_standardization/Sub_1"
  input: "batch_processing/per_image_standardization/Maximum"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/key_image/class/label"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Reshape/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Reshape"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_1/key_image/class/label"
  input: "batch_processing/ParseSingleExample_1/Reshape/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/key_image/class/text"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Reshape_1/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Reshape_1"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_1/key_image/class/text"
  input: "batch_processing/ParseSingleExample_1/Reshape_1/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/key_image/encoded"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Reshape_2/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Reshape_2"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_1/key_image/encoded"
  input: "batch_processing/ParseSingleExample_1/Reshape_2/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/key_image/filename"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Reshape_3/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Reshape_3"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_1/key_image/filename"
  input: "batch_processing/ParseSingleExample_1/Reshape_3/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/key_image/height"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Reshape_4/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Reshape_4"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_1/key_image/height"
  input: "batch_processing/ParseSingleExample_1/Reshape_4/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/key_image/width"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Reshape_5/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/Reshape_5"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_1/key_image/width"
  input: "batch_processing/ParseSingleExample_1/Reshape_5/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_1/ParseSingleExample"
  op: "ParseSingleExample"
  input: "batch_processing/ReaderReadV2:1"
  input: "batch_processing/ParseSingleExample_1/Reshape"
  input: "batch_processing/ParseSingleExample_1/Reshape_1"
  input: "batch_processing/ParseSingleExample_1/Reshape_2"
  input: "batch_processing/ParseSingleExample_1/Reshape_3"
  input: "batch_processing/ParseSingleExample_1/Reshape_4"
  input: "batch_processing/ParseSingleExample_1/Reshape_5"
  device: "/device:CPU:0"
  attr {
    key: "Tdense"
    value {
      list {
        type: DT_INT64
        type: DT_STRING
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
        type: DT_INT64
      }
    }
  }
  attr {
    key: "dense_keys"
    value {
      list {
        s: "image/class/label"
        s: "image/class/text"
        s: "image/encoded"
        s: "image/filename"
        s: "image/height"
        s: "image/width"
      }
    }
  }
  attr {
    key: "dense_shapes"
    value {
      list {
        shape {
          dim {
            size: 1
          }
        }
        shape {
        }
        shape {
        }
        shape {
        }
        shape {
          dim {
            size: 1
          }
        }
        shape {
          dim {
            size: 1
          }
        }
      }
    }
  }
  attr {
    key: "num_sparse"
    value {
      i: 0
    }
  }
  attr {
    key: "sparse_keys"
    value {
      list {
      }
    }
  }
  attr {
    key: "sparse_types"
    value {
      list {
      }
    }
  }
}
node {
  name: "batch_processing/Cast_1"
  op: "Cast"
  input: "batch_processing/ParseSingleExample_1/ParseSingleExample"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_1/DecodeJpeg"
  op: "DecodeJpeg"
  input: "batch_processing/ParseSingleExample_1/ParseSingleExample:2"
  device: "/device:CPU:0"
  attr {
    key: "acceptable_fraction"
    value {
      f: 1.0
    }
  }
  attr {
    key: "channels"
    value {
      i: 3
    }
  }
  attr {
    key: "dct_method"
    value {
      s: ""
    }
  }
  attr {
    key: "fancy_upscaling"
    value {
      b: true
    }
  }
  attr {
    key: "ratio"
    value {
      i: 1
    }
  }
  attr {
    key: "try_recover_truncated"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_1/convert_image/Cast"
  op: "Cast"
  input: "batch_processing/decode_jpeg_1/DecodeJpeg"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_UINT8
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_1/convert_image/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.003921568859368563
      }
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_1/convert_image"
  op: "Mul"
  input: "batch_processing/decode_jpeg_1/convert_image/Cast"
  input: "batch_processing/decode_jpeg_1/convert_image/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_crop_1/size"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/Shape"
  op: "Shape"
  input: "batch_processing/decode_jpeg_1/convert_image"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_1/GreaterEqual"
  op: "GreaterEqual"
  input: "batch_processing/random_crop_1/Shape"
  input: "batch_processing/random_crop_1/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_1/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/All"
  op: "All"
  input: "batch_processing/random_crop_1/GreaterEqual"
  input: "batch_processing/random_crop_1/Const"
  device: "/device:CPU:0"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/random_crop_1/Assert/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/Assert/Assert/data_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/Assert/Assert"
  op: "Assert"
  input: "batch_processing/random_crop_1/All"
  input: "batch_processing/random_crop_1/Assert/Assert/data_0"
  input: "batch_processing/random_crop_1/Shape"
  input: "batch_processing/random_crop_1/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_INT32
        type: DT_INT32
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 1000
    }
  }
}
node {
  name: "batch_processing/random_crop_1/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop_1/Shape"
  input: "^batch_processing/random_crop_1/Assert/Assert"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_1/Shape"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/sub"
  op: "Sub"
  input: "batch_processing/random_crop_1/control_dependency"
  input: "batch_processing/random_crop_1/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_1/add/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/add"
  op: "Add"
  input: "batch_processing/random_crop_1/sub"
  input: "batch_processing/random_crop_1/add/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_1/Shape_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2147483647
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_1/random_uniform"
  op: "RandomUniformInt"
  input: "batch_processing/random_crop_1/Shape_1"
  input: "batch_processing/random_crop_1/random_uniform/min"
  input: "batch_processing/random_crop_1/random_uniform/max"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tout"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_crop_1/mod"
  op: "FloorMod"
  input: "batch_processing/random_crop_1/random_uniform"
  input: "batch_processing/random_crop_1/add"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_1"
  op: "Slice"
  input: "batch_processing/decode_jpeg_1/convert_image"
  input: "batch_processing/random_crop_1/mod"
  input: "batch_processing/random_crop_1/size"
  device: "/device:CPU:0"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_1"
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/random_uniform/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_flip_left_right_1/random_uniform/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/random_uniform/sub"
  op: "Sub"
  input: "batch_processing/random_flip_left_right_1/random_uniform/max"
  input: "batch_processing/random_flip_left_right_1/random_uniform/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/random_uniform/mul"
  op: "Mul"
  input: "batch_processing/random_flip_left_right_1/random_uniform/RandomUniform"
  input: "batch_processing/random_flip_left_right_1/random_uniform/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/random_uniform"
  op: "Add"
  input: "batch_processing/random_flip_left_right_1/random_uniform/mul"
  input: "batch_processing/random_flip_left_right_1/random_uniform/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/Less/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.5
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/Less"
  op: "Less"
  input: "batch_processing/random_flip_left_right_1/random_uniform"
  input: "batch_processing/random_flip_left_right_1/Less/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/Switch"
  op: "Switch"
  input: "batch_processing/random_flip_left_right_1/Less"
  input: "batch_processing/random_flip_left_right_1/Less"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/switch_t"
  op: "Identity"
  input: "batch_processing/random_flip_left_right_1/Switch:1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/switch_f"
  op: "Identity"
  input: "batch_processing/random_flip_left_right_1/Switch"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/pred_id"
  op: "Identity"
  input: "batch_processing/random_flip_left_right_1/Less"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/ReverseV2/axis"
  op: "Const"
  input: "^batch_processing/random_flip_left_right_1/switch_t"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/ReverseV2"
  op: "ReverseV2"
  input: "batch_processing/random_flip_left_right_1/ReverseV2/Switch:1"
  input: "batch_processing/random_flip_left_right_1/ReverseV2/axis"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/ReverseV2/Switch"
  op: "Switch"
  input: "batch_processing/random_flip_left_right_1/control_dependency"
  input: "batch_processing/random_flip_left_right_1/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_1"
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/Switch_1"
  op: "Switch"
  input: "batch_processing/random_flip_left_right_1/control_dependency"
  input: "batch_processing/random_flip_left_right_1/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_1"
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_1/Merge"
  op: "Merge"
  input: "batch_processing/random_flip_left_right_1/Switch_1"
  input: "batch_processing/random_flip_left_right_1/ReverseV2"
  device: "/device:CPU:0"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_2/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_2/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_2/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_2/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_2/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_2/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_2/max"
  input: "batch_processing/random_uniform_2/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_2/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_2/RandomUniform"
  input: "batch_processing/random_uniform_2/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_2"
  op: "Add"
  input: "batch_processing/random_uniform_2/mul"
  input: "batch_processing/random_uniform_2/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_1/Identity"
  op: "Identity"
  input: "batch_processing/random_flip_left_right_1/Merge"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_1"
  op: "Add"
  input: "batch_processing/adjust_brightness_1/Identity"
  input: "batch_processing/random_uniform_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_1/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_brightness_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_3/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_3/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.20000000298023224
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_3/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.7999999523162842
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_3/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_3/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_3/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_3/max"
  input: "batch_processing/random_uniform_3/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_3/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_3/RandomUniform"
  input: "batch_processing/random_uniform_3/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_3"
  op: "Add"
  input: "batch_processing/random_uniform_3/mul"
  input: "batch_processing/random_uniform_3/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast_1/Identity"
  op: "Identity"
  input: "batch_processing/adjust_brightness_1/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast_1"
  op: "AdjustContrastv2"
  input: "batch_processing/adjust_contrast_1/Identity"
  input: "batch_processing/random_uniform_3"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/adjust_contrast_1/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_contrast_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/control_dependency"
  op: "Identity"
  input: "batch_processing/adjust_contrast_1/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/adjust_contrast_1/Identity_1"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/strided_slice/stack"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: -3
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/strided_slice/stack_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/strided_slice/stack_2"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/strided_slice"
  op: "StridedSlice"
  input: "batch_processing/per_image_standardization_1/Shape"
  input: "batch_processing/per_image_standardization_1/strided_slice/stack"
  input: "batch_processing/per_image_standardization_1/strided_slice/stack_1"
  input: "batch_processing/per_image_standardization_1/strided_slice/stack_2"
  device: "/device:CPU:0"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 1
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Prod"
  op: "Prod"
  input: "batch_processing/per_image_standardization_1/strided_slice"
  input: "batch_processing/per_image_standardization_1/Const"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Mean/reduction_indices"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\377\377\377\377\376\377\377\377\375\377\377\377"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Mean"
  op: "Mean"
  input: "batch_processing/per_image_standardization_1/control_dependency"
  input: "batch_processing/per_image_standardization_1/Mean/reduction_indices"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Square"
  op: "Square"
  input: "batch_processing/per_image_standardization_1/control_dependency"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Mean_1/reduction_indices"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\377\377\377\377\376\377\377\377\375\377\377\377"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Mean_1"
  op: "Mean"
  input: "batch_processing/per_image_standardization_1/Square"
  input: "batch_processing/per_image_standardization_1/Mean_1/reduction_indices"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Square_1"
  op: "Square"
  input: "batch_processing/per_image_standardization_1/Mean"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/sub"
  op: "Sub"
  input: "batch_processing/per_image_standardization_1/Mean_1"
  input: "batch_processing/per_image_standardization_1/Square_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Relu"
  op: "Relu"
  input: "batch_processing/per_image_standardization_1/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Sqrt"
  op: "Sqrt"
  input: "batch_processing/per_image_standardization_1/Relu"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Cast"
  op: "Cast"
  input: "batch_processing/per_image_standardization_1/Prod"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Rsqrt"
  op: "Rsqrt"
  input: "batch_processing/per_image_standardization_1/Cast"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Maximum"
  op: "Maximum"
  input: "batch_processing/per_image_standardization_1/Sqrt"
  input: "batch_processing/per_image_standardization_1/Rsqrt"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1/Sub_1"
  op: "Sub"
  input: "batch_processing/per_image_standardization_1/control_dependency"
  input: "batch_processing/per_image_standardization_1/Mean"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_1"
  op: "RealDiv"
  input: "batch_processing/per_image_standardization_1/Sub_1"
  input: "batch_processing/per_image_standardization_1/Maximum"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/key_image/class/label"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Reshape/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Reshape"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_2/key_image/class/label"
  input: "batch_processing/ParseSingleExample_2/Reshape/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/key_image/class/text"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Reshape_1/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Reshape_1"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_2/key_image/class/text"
  input: "batch_processing/ParseSingleExample_2/Reshape_1/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/key_image/encoded"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Reshape_2/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Reshape_2"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_2/key_image/encoded"
  input: "batch_processing/ParseSingleExample_2/Reshape_2/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/key_image/filename"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Reshape_3/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Reshape_3"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_2/key_image/filename"
  input: "batch_processing/ParseSingleExample_2/Reshape_3/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/key_image/height"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Reshape_4/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Reshape_4"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_2/key_image/height"
  input: "batch_processing/ParseSingleExample_2/Reshape_4/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/key_image/width"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Reshape_5/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/Reshape_5"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_2/key_image/width"
  input: "batch_processing/ParseSingleExample_2/Reshape_5/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_2/ParseSingleExample"
  op: "ParseSingleExample"
  input: "batch_processing/ReaderReadV2:1"
  input: "batch_processing/ParseSingleExample_2/Reshape"
  input: "batch_processing/ParseSingleExample_2/Reshape_1"
  input: "batch_processing/ParseSingleExample_2/Reshape_2"
  input: "batch_processing/ParseSingleExample_2/Reshape_3"
  input: "batch_processing/ParseSingleExample_2/Reshape_4"
  input: "batch_processing/ParseSingleExample_2/Reshape_5"
  device: "/device:CPU:0"
  attr {
    key: "Tdense"
    value {
      list {
        type: DT_INT64
        type: DT_STRING
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
        type: DT_INT64
      }
    }
  }
  attr {
    key: "dense_keys"
    value {
      list {
        s: "image/class/label"
        s: "image/class/text"
        s: "image/encoded"
        s: "image/filename"
        s: "image/height"
        s: "image/width"
      }
    }
  }
  attr {
    key: "dense_shapes"
    value {
      list {
        shape {
          dim {
            size: 1
          }
        }
        shape {
        }
        shape {
        }
        shape {
        }
        shape {
          dim {
            size: 1
          }
        }
        shape {
          dim {
            size: 1
          }
        }
      }
    }
  }
  attr {
    key: "num_sparse"
    value {
      i: 0
    }
  }
  attr {
    key: "sparse_keys"
    value {
      list {
      }
    }
  }
  attr {
    key: "sparse_types"
    value {
      list {
      }
    }
  }
}
node {
  name: "batch_processing/Cast_2"
  op: "Cast"
  input: "batch_processing/ParseSingleExample_2/ParseSingleExample"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_2/DecodeJpeg"
  op: "DecodeJpeg"
  input: "batch_processing/ParseSingleExample_2/ParseSingleExample:2"
  device: "/device:CPU:0"
  attr {
    key: "acceptable_fraction"
    value {
      f: 1.0
    }
  }
  attr {
    key: "channels"
    value {
      i: 3
    }
  }
  attr {
    key: "dct_method"
    value {
      s: ""
    }
  }
  attr {
    key: "fancy_upscaling"
    value {
      b: true
    }
  }
  attr {
    key: "ratio"
    value {
      i: 1
    }
  }
  attr {
    key: "try_recover_truncated"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_2/convert_image/Cast"
  op: "Cast"
  input: "batch_processing/decode_jpeg_2/DecodeJpeg"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_UINT8
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_2/convert_image/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.003921568859368563
      }
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_2/convert_image"
  op: "Mul"
  input: "batch_processing/decode_jpeg_2/convert_image/Cast"
  input: "batch_processing/decode_jpeg_2/convert_image/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_crop_2/size"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/Shape"
  op: "Shape"
  input: "batch_processing/decode_jpeg_2/convert_image"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_2/GreaterEqual"
  op: "GreaterEqual"
  input: "batch_processing/random_crop_2/Shape"
  input: "batch_processing/random_crop_2/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_2/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/All"
  op: "All"
  input: "batch_processing/random_crop_2/GreaterEqual"
  input: "batch_processing/random_crop_2/Const"
  device: "/device:CPU:0"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/random_crop_2/Assert/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/Assert/Assert/data_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/Assert/Assert"
  op: "Assert"
  input: "batch_processing/random_crop_2/All"
  input: "batch_processing/random_crop_2/Assert/Assert/data_0"
  input: "batch_processing/random_crop_2/Shape"
  input: "batch_processing/random_crop_2/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_INT32
        type: DT_INT32
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 1000
    }
  }
}
node {
  name: "batch_processing/random_crop_2/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop_2/Shape"
  input: "^batch_processing/random_crop_2/Assert/Assert"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_2/Shape"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/sub"
  op: "Sub"
  input: "batch_processing/random_crop_2/control_dependency"
  input: "batch_processing/random_crop_2/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_2/add/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/add"
  op: "Add"
  input: "batch_processing/random_crop_2/sub"
  input: "batch_processing/random_crop_2/add/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_2/Shape_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2147483647
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_2/random_uniform"
  op: "RandomUniformInt"
  input: "batch_processing/random_crop_2/Shape_1"
  input: "batch_processing/random_crop_2/random_uniform/min"
  input: "batch_processing/random_crop_2/random_uniform/max"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tout"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_crop_2/mod"
  op: "FloorMod"
  input: "batch_processing/random_crop_2/random_uniform"
  input: "batch_processing/random_crop_2/add"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_2"
  op: "Slice"
  input: "batch_processing/decode_jpeg_2/convert_image"
  input: "batch_processing/random_crop_2/mod"
  input: "batch_processing/random_crop_2/size"
  device: "/device:CPU:0"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_2"
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/random_uniform/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_flip_left_right_2/random_uniform/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/random_uniform/sub"
  op: "Sub"
  input: "batch_processing/random_flip_left_right_2/random_uniform/max"
  input: "batch_processing/random_flip_left_right_2/random_uniform/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/random_uniform/mul"
  op: "Mul"
  input: "batch_processing/random_flip_left_right_2/random_uniform/RandomUniform"
  input: "batch_processing/random_flip_left_right_2/random_uniform/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/random_uniform"
  op: "Add"
  input: "batch_processing/random_flip_left_right_2/random_uniform/mul"
  input: "batch_processing/random_flip_left_right_2/random_uniform/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/Less/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.5
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/Less"
  op: "Less"
  input: "batch_processing/random_flip_left_right_2/random_uniform"
  input: "batch_processing/random_flip_left_right_2/Less/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/Switch"
  op: "Switch"
  input: "batch_processing/random_flip_left_right_2/Less"
  input: "batch_processing/random_flip_left_right_2/Less"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/switch_t"
  op: "Identity"
  input: "batch_processing/random_flip_left_right_2/Switch:1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/switch_f"
  op: "Identity"
  input: "batch_processing/random_flip_left_right_2/Switch"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/pred_id"
  op: "Identity"
  input: "batch_processing/random_flip_left_right_2/Less"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/ReverseV2/axis"
  op: "Const"
  input: "^batch_processing/random_flip_left_right_2/switch_t"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/ReverseV2"
  op: "ReverseV2"
  input: "batch_processing/random_flip_left_right_2/ReverseV2/Switch:1"
  input: "batch_processing/random_flip_left_right_2/ReverseV2/axis"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/ReverseV2/Switch"
  op: "Switch"
  input: "batch_processing/random_flip_left_right_2/control_dependency"
  input: "batch_processing/random_flip_left_right_2/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_2"
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/Switch_1"
  op: "Switch"
  input: "batch_processing/random_flip_left_right_2/control_dependency"
  input: "batch_processing/random_flip_left_right_2/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_2"
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_2/Merge"
  op: "Merge"
  input: "batch_processing/random_flip_left_right_2/Switch_1"
  input: "batch_processing/random_flip_left_right_2/ReverseV2"
  device: "/device:CPU:0"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_4/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_4/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_4/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_4/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_4/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_4/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_4/max"
  input: "batch_processing/random_uniform_4/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_4/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_4/RandomUniform"
  input: "batch_processing/random_uniform_4/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_4"
  op: "Add"
  input: "batch_processing/random_uniform_4/mul"
  input: "batch_processing/random_uniform_4/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_2/Identity"
  op: "Identity"
  input: "batch_processing/random_flip_left_right_2/Merge"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_2"
  op: "Add"
  input: "batch_processing/adjust_brightness_2/Identity"
  input: "batch_processing/random_uniform_4"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_2/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_brightness_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_5/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_5/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.20000000298023224
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_5/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.7999999523162842
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_5/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_5/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_5/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_5/max"
  input: "batch_processing/random_uniform_5/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_5/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_5/RandomUniform"
  input: "batch_processing/random_uniform_5/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_5"
  op: "Add"
  input: "batch_processing/random_uniform_5/mul"
  input: "batch_processing/random_uniform_5/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast_2/Identity"
  op: "Identity"
  input: "batch_processing/adjust_brightness_2/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast_2"
  op: "AdjustContrastv2"
  input: "batch_processing/adjust_contrast_2/Identity"
  input: "batch_processing/random_uniform_5"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/adjust_contrast_2/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_contrast_2"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/control_dependency"
  op: "Identity"
  input: "batch_processing/adjust_contrast_2/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/adjust_contrast_2/Identity_1"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/strided_slice/stack"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: -3
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/strided_slice/stack_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/strided_slice/stack_2"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/strided_slice"
  op: "StridedSlice"
  input: "batch_processing/per_image_standardization_2/Shape"
  input: "batch_processing/per_image_standardization_2/strided_slice/stack"
  input: "batch_processing/per_image_standardization_2/strided_slice/stack_1"
  input: "batch_processing/per_image_standardization_2/strided_slice/stack_2"
  device: "/device:CPU:0"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 1
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Prod"
  op: "Prod"
  input: "batch_processing/per_image_standardization_2/strided_slice"
  input: "batch_processing/per_image_standardization_2/Const"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Mean/reduction_indices"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\377\377\377\377\376\377\377\377\375\377\377\377"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Mean"
  op: "Mean"
  input: "batch_processing/per_image_standardization_2/control_dependency"
  input: "batch_processing/per_image_standardization_2/Mean/reduction_indices"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Square"
  op: "Square"
  input: "batch_processing/per_image_standardization_2/control_dependency"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Mean_1/reduction_indices"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\377\377\377\377\376\377\377\377\375\377\377\377"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Mean_1"
  op: "Mean"
  input: "batch_processing/per_image_standardization_2/Square"
  input: "batch_processing/per_image_standardization_2/Mean_1/reduction_indices"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Square_1"
  op: "Square"
  input: "batch_processing/per_image_standardization_2/Mean"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/sub"
  op: "Sub"
  input: "batch_processing/per_image_standardization_2/Mean_1"
  input: "batch_processing/per_image_standardization_2/Square_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Relu"
  op: "Relu"
  input: "batch_processing/per_image_standardization_2/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Sqrt"
  op: "Sqrt"
  input: "batch_processing/per_image_standardization_2/Relu"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Cast"
  op: "Cast"
  input: "batch_processing/per_image_standardization_2/Prod"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Rsqrt"
  op: "Rsqrt"
  input: "batch_processing/per_image_standardization_2/Cast"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Maximum"
  op: "Maximum"
  input: "batch_processing/per_image_standardization_2/Sqrt"
  input: "batch_processing/per_image_standardization_2/Rsqrt"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2/Sub_1"
  op: "Sub"
  input: "batch_processing/per_image_standardization_2/control_dependency"
  input: "batch_processing/per_image_standardization_2/Mean"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_2"
  op: "RealDiv"
  input: "batch_processing/per_image_standardization_2/Sub_1"
  input: "batch_processing/per_image_standardization_2/Maximum"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/key_image/class/label"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Reshape/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Reshape"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_3/key_image/class/label"
  input: "batch_processing/ParseSingleExample_3/Reshape/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/key_image/class/text"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Reshape_1/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Reshape_1"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_3/key_image/class/text"
  input: "batch_processing/ParseSingleExample_3/Reshape_1/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/key_image/encoded"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Reshape_2/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Reshape_2"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_3/key_image/encoded"
  input: "batch_processing/ParseSingleExample_3/Reshape_2/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/key_image/filename"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Reshape_3/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Reshape_3"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_3/key_image/filename"
  input: "batch_processing/ParseSingleExample_3/Reshape_3/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/key_image/height"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Reshape_4/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Reshape_4"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_3/key_image/height"
  input: "batch_processing/ParseSingleExample_3/Reshape_4/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/key_image/width"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT64
        tensor_shape {
        }
        int64_val: -1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Reshape_5/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/Reshape_5"
  op: "Reshape"
  input: "batch_processing/ParseSingleExample_3/key_image/width"
  input: "batch_processing/ParseSingleExample_3/Reshape_5/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/ParseSingleExample_3/ParseSingleExample"
  op: "ParseSingleExample"
  input: "batch_processing/ReaderReadV2:1"
  input: "batch_processing/ParseSingleExample_3/Reshape"
  input: "batch_processing/ParseSingleExample_3/Reshape_1"
  input: "batch_processing/ParseSingleExample_3/Reshape_2"
  input: "batch_processing/ParseSingleExample_3/Reshape_3"
  input: "batch_processing/ParseSingleExample_3/Reshape_4"
  input: "batch_processing/ParseSingleExample_3/Reshape_5"
  device: "/device:CPU:0"
  attr {
    key: "Tdense"
    value {
      list {
        type: DT_INT64
        type: DT_STRING
        type: DT_STRING
        type: DT_STRING
        type: DT_INT64
        type: DT_INT64
      }
    }
  }
  attr {
    key: "dense_keys"
    value {
      list {
        s: "image/class/label"
        s: "image/class/text"
        s: "image/encoded"
        s: "image/filename"
        s: "image/height"
        s: "image/width"
      }
    }
  }
  attr {
    key: "dense_shapes"
    value {
      list {
        shape {
          dim {
            size: 1
          }
        }
        shape {
        }
        shape {
        }
        shape {
        }
        shape {
          dim {
            size: 1
          }
        }
        shape {
          dim {
            size: 1
          }
        }
      }
    }
  }
  attr {
    key: "num_sparse"
    value {
      i: 0
    }
  }
  attr {
    key: "sparse_keys"
    value {
      list {
      }
    }
  }
  attr {
    key: "sparse_types"
    value {
      list {
      }
    }
  }
}
node {
  name: "batch_processing/Cast_3"
  op: "Cast"
  input: "batch_processing/ParseSingleExample_3/ParseSingleExample"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT64
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_3/DecodeJpeg"
  op: "DecodeJpeg"
  input: "batch_processing/ParseSingleExample_3/ParseSingleExample:2"
  device: "/device:CPU:0"
  attr {
    key: "acceptable_fraction"
    value {
      f: 1.0
    }
  }
  attr {
    key: "channels"
    value {
      i: 3
    }
  }
  attr {
    key: "dct_method"
    value {
      s: ""
    }
  }
  attr {
    key: "fancy_upscaling"
    value {
      b: true
    }
  }
  attr {
    key: "ratio"
    value {
      i: 1
    }
  }
  attr {
    key: "try_recover_truncated"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_3/convert_image/Cast"
  op: "Cast"
  input: "batch_processing/decode_jpeg_3/DecodeJpeg"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_UINT8
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_3/convert_image/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.003921568859368563
      }
    }
  }
}
node {
  name: "batch_processing/decode_jpeg_3/convert_image"
  op: "Mul"
  input: "batch_processing/decode_jpeg_3/convert_image/Cast"
  input: "batch_processing/decode_jpeg_3/convert_image/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_crop_3/size"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/Shape"
  op: "Shape"
  input: "batch_processing/decode_jpeg_3/convert_image"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_3/GreaterEqual"
  op: "GreaterEqual"
  input: "batch_processing/random_crop_3/Shape"
  input: "batch_processing/random_crop_3/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_3/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/All"
  op: "All"
  input: "batch_processing/random_crop_3/GreaterEqual"
  input: "batch_processing/random_crop_3/Const"
  device: "/device:CPU:0"
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/random_crop_3/Assert/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/Assert/Assert/data_0"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "Need value.shape >= size, got "
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/Assert/Assert"
  op: "Assert"
  input: "batch_processing/random_crop_3/All"
  input: "batch_processing/random_crop_3/Assert/Assert/data_0"
  input: "batch_processing/random_crop_3/Shape"
  input: "batch_processing/random_crop_3/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      list {
        type: DT_STRING
        type: DT_INT32
        type: DT_INT32
      }
    }
  }
  attr {
    key: "summarize"
    value {
      i: 1000
    }
  }
}
node {
  name: "batch_processing/random_crop_3/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop_3/Shape"
  input: "^batch_processing/random_crop_3/Assert/Assert"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_3/Shape"
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/sub"
  op: "Sub"
  input: "batch_processing/random_crop_3/control_dependency"
  input: "batch_processing/random_crop_3/size"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_3/add/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/add"
  op: "Add"
  input: "batch_processing/random_crop_3/sub"
  input: "batch_processing/random_crop_3/add/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_3/Shape_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 3
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 2147483647
      }
    }
  }
}
node {
  name: "batch_processing/random_crop_3/random_uniform"
  op: "RandomUniformInt"
  input: "batch_processing/random_crop_3/Shape_1"
  input: "batch_processing/random_crop_3/random_uniform/min"
  input: "batch_processing/random_crop_3/random_uniform/max"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tout"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_crop_3/mod"
  op: "FloorMod"
  input: "batch_processing/random_crop_3/random_uniform"
  input: "batch_processing/random_crop_3/add"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_crop_3"
  op: "Slice"
  input: "batch_processing/decode_jpeg_3/convert_image"
  input: "batch_processing/random_crop_3/mod"
  input: "batch_processing/random_crop_3/size"
  device: "/device:CPU:0"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/control_dependency"
  op: "Identity"
  input: "batch_processing/random_crop_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_3"
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/random_uniform/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/random_uniform/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/random_uniform/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/random_uniform/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_flip_left_right_3/random_uniform/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/random_uniform/sub"
  op: "Sub"
  input: "batch_processing/random_flip_left_right_3/random_uniform/max"
  input: "batch_processing/random_flip_left_right_3/random_uniform/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/random_uniform/mul"
  op: "Mul"
  input: "batch_processing/random_flip_left_right_3/random_uniform/RandomUniform"
  input: "batch_processing/random_flip_left_right_3/random_uniform/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/random_uniform"
  op: "Add"
  input: "batch_processing/random_flip_left_right_3/random_uniform/mul"
  input: "batch_processing/random_flip_left_right_3/random_uniform/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/Less/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.5
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/Less"
  op: "Less"
  input: "batch_processing/random_flip_left_right_3/random_uniform"
  input: "batch_processing/random_flip_left_right_3/Less/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/Switch"
  op: "Switch"
  input: "batch_processing/random_flip_left_right_3/Less"
  input: "batch_processing/random_flip_left_right_3/Less"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/switch_t"
  op: "Identity"
  input: "batch_processing/random_flip_left_right_3/Switch:1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/switch_f"
  op: "Identity"
  input: "batch_processing/random_flip_left_right_3/Switch"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/pred_id"
  op: "Identity"
  input: "batch_processing/random_flip_left_right_3/Less"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_BOOL
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/ReverseV2/axis"
  op: "Const"
  input: "^batch_processing/random_flip_left_right_3/switch_t"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/ReverseV2"
  op: "ReverseV2"
  input: "batch_processing/random_flip_left_right_3/ReverseV2/Switch:1"
  input: "batch_processing/random_flip_left_right_3/ReverseV2/axis"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/ReverseV2/Switch"
  op: "Switch"
  input: "batch_processing/random_flip_left_right_3/control_dependency"
  input: "batch_processing/random_flip_left_right_3/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_3"
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/Switch_1"
  op: "Switch"
  input: "batch_processing/random_flip_left_right_3/control_dependency"
  input: "batch_processing/random_flip_left_right_3/pred_id"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/random_crop_3"
      }
    }
  }
}
node {
  name: "batch_processing/random_flip_left_right_3/Merge"
  op: "Merge"
  input: "batch_processing/random_flip_left_right_3/Switch_1"
  input: "batch_processing/random_flip_left_right_3/ReverseV2"
  device: "/device:CPU:0"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_6/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_6/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: -63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_6/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 63.0
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_6/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_6/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_6/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_6/max"
  input: "batch_processing/random_uniform_6/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_6/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_6/RandomUniform"
  input: "batch_processing/random_uniform_6/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_6"
  op: "Add"
  input: "batch_processing/random_uniform_6/mul"
  input: "batch_processing/random_uniform_6/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_3/Identity"
  op: "Identity"
  input: "batch_processing/random_flip_left_right_3/Merge"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_3"
  op: "Add"
  input: "batch_processing/adjust_brightness_3/Identity"
  input: "batch_processing/random_uniform_6"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_brightness_3/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_brightness_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_7/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_7/min"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.20000000298023224
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_7/max"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.7999999523162842
      }
    }
  }
}
node {
  name: "batch_processing/random_uniform_7/RandomUniform"
  op: "RandomUniform"
  input: "batch_processing/random_uniform_7/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/random_uniform_7/sub"
  op: "Sub"
  input: "batch_processing/random_uniform_7/max"
  input: "batch_processing/random_uniform_7/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_7/mul"
  op: "Mul"
  input: "batch_processing/random_uniform_7/RandomUniform"
  input: "batch_processing/random_uniform_7/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/random_uniform_7"
  op: "Add"
  input: "batch_processing/random_uniform_7/mul"
  input: "batch_processing/random_uniform_7/min"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast_3/Identity"
  op: "Identity"
  input: "batch_processing/adjust_brightness_3/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/adjust_contrast_3"
  op: "AdjustContrastv2"
  input: "batch_processing/adjust_contrast_3/Identity"
  input: "batch_processing/random_uniform_7"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/adjust_contrast_3/Identity_1"
  op: "Identity"
  input: "batch_processing/adjust_contrast_3"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/control_dependency"
  op: "Identity"
  input: "batch_processing/adjust_contrast_3/Identity_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@batch_processing/adjust_contrast_3/Identity_1"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/strided_slice/stack"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: -3
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/strided_slice/stack_1"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/strided_slice/stack_2"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/strided_slice"
  op: "StridedSlice"
  input: "batch_processing/per_image_standardization_3/Shape"
  input: "batch_processing/per_image_standardization_3/strided_slice/stack"
  input: "batch_processing/per_image_standardization_3/strided_slice/stack_1"
  input: "batch_processing/per_image_standardization_3/strided_slice/stack_2"
  device: "/device:CPU:0"
  attr {
    key: "Index"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "begin_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "ellipsis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "end_mask"
    value {
      i: 1
    }
  }
  attr {
    key: "new_axis_mask"
    value {
      i: 0
    }
  }
  attr {
    key: "shrink_axis_mask"
    value {
      i: 0
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Prod"
  op: "Prod"
  input: "batch_processing/per_image_standardization_3/strided_slice"
  input: "batch_processing/per_image_standardization_3/Const"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Mean/reduction_indices"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\377\377\377\377\376\377\377\377\375\377\377\377"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Mean"
  op: "Mean"
  input: "batch_processing/per_image_standardization_3/control_dependency"
  input: "batch_processing/per_image_standardization_3/Mean/reduction_indices"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Square"
  op: "Square"
  input: "batch_processing/per_image_standardization_3/control_dependency"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Mean_1/reduction_indices"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 3
          }
        }
        tensor_content: "\377\377\377\377\376\377\377\377\375\377\377\377"
      }
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Mean_1"
  op: "Mean"
  input: "batch_processing/per_image_standardization_3/Square"
  input: "batch_processing/per_image_standardization_3/Mean_1/reduction_indices"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Square_1"
  op: "Square"
  input: "batch_processing/per_image_standardization_3/Mean"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/sub"
  op: "Sub"
  input: "batch_processing/per_image_standardization_3/Mean_1"
  input: "batch_processing/per_image_standardization_3/Square_1"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Relu"
  op: "Relu"
  input: "batch_processing/per_image_standardization_3/sub"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Sqrt"
  op: "Sqrt"
  input: "batch_processing/per_image_standardization_3/Relu"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Cast"
  op: "Cast"
  input: "batch_processing/per_image_standardization_3/Prod"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Rsqrt"
  op: "Rsqrt"
  input: "batch_processing/per_image_standardization_3/Cast"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Maximum"
  op: "Maximum"
  input: "batch_processing/per_image_standardization_3/Sqrt"
  input: "batch_processing/per_image_standardization_3/Rsqrt"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3/Sub_1"
  op: "Sub"
  input: "batch_processing/per_image_standardization_3/control_dependency"
  input: "batch_processing/per_image_standardization_3/Mean"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/per_image_standardization_3"
  op: "RealDiv"
  input: "batch_processing/per_image_standardization_3/Sub_1"
  input: "batch_processing/per_image_standardization_3/Maximum"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/batch_join/Const"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_BOOL
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_BOOL
        tensor_shape {
        }
        bool_val: true
      }
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue"
  op: "FIFOQueueV2"
  device: "/device:CPU:0"
  attr {
    key: "capacity"
    value {
      i: 2048
    }
  }
  attr {
    key: "component_types"
    value {
      list {
        type: DT_FLOAT
        type: DT_INT32
        type: DT_STRING
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "shapes"
    value {
      list {
        shape {
          dim {
            size: 227
          }
          dim {
            size: 227
          }
          dim {
            size: 3
          }
        }
        shape {
          dim {
            size: 1
          }
        }
        shape {
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_enqueue"
  op: "QueueEnqueueV2"
  input: "batch_processing/batch_join/fifo_queue"
  input: "batch_processing/per_image_standardization"
  input: "batch_processing/Cast"
  input: "batch_processing/ParseSingleExample/ParseSingleExample:3"
  device: "/device:CPU:0"
  attr {
    key: "Tcomponents"
    value {
      list {
        type: DT_FLOAT
        type: DT_INT32
        type: DT_STRING
      }
    }
  }
  attr {
    key: "timeout_ms"
    value {
      i: -1
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_enqueue_1"
  op: "QueueEnqueueV2"
  input: "batch_processing/batch_join/fifo_queue"
  input: "batch_processing/per_image_standardization_1"
  input: "batch_processing/Cast_1"
  input: "batch_processing/ParseSingleExample_1/ParseSingleExample:3"
  device: "/device:CPU:0"
  attr {
    key: "Tcomponents"
    value {
      list {
        type: DT_FLOAT
        type: DT_INT32
        type: DT_STRING
      }
    }
  }
  attr {
    key: "timeout_ms"
    value {
      i: -1
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_enqueue_2"
  op: "QueueEnqueueV2"
  input: "batch_processing/batch_join/fifo_queue"
  input: "batch_processing/per_image_standardization_2"
  input: "batch_processing/Cast_2"
  input: "batch_processing/ParseSingleExample_2/ParseSingleExample:3"
  device: "/device:CPU:0"
  attr {
    key: "Tcomponents"
    value {
      list {
        type: DT_FLOAT
        type: DT_INT32
        type: DT_STRING
      }
    }
  }
  attr {
    key: "timeout_ms"
    value {
      i: -1
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_enqueue_3"
  op: "QueueEnqueueV2"
  input: "batch_processing/batch_join/fifo_queue"
  input: "batch_processing/per_image_standardization_3"
  input: "batch_processing/Cast_3"
  input: "batch_processing/ParseSingleExample_3/ParseSingleExample:3"
  device: "/device:CPU:0"
  attr {
    key: "Tcomponents"
    value {
      list {
        type: DT_FLOAT
        type: DT_INT32
        type: DT_STRING
      }
    }
  }
  attr {
    key: "timeout_ms"
    value {
      i: -1
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_Close"
  op: "QueueCloseV2"
  input: "batch_processing/batch_join/fifo_queue"
  device: "/device:CPU:0"
  attr {
    key: "cancel_pending_enqueues"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_Close_1"
  op: "QueueCloseV2"
  input: "batch_processing/batch_join/fifo_queue"
  device: "/device:CPU:0"
  attr {
    key: "cancel_pending_enqueues"
    value {
      b: true
    }
  }
}
node {
  name: "batch_processing/batch_join/fifo_queue_Size"
  op: "QueueSizeV2"
  input: "batch_processing/batch_join/fifo_queue"
  device: "/device:CPU:0"
}
node {
  name: "batch_processing/batch_join/ToFloat"
  op: "Cast"
  input: "batch_processing/batch_join/fifo_queue_Size"
  device: "/device:CPU:0"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "batch_processing/batch_join/mul/y"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00048828125
      }
    }
  }
}
node {
  name: "batch_processing/batch_join/mul"
  op: "Mul"
  input: "batch_processing/batch_join/ToFloat"
  input: "batch_processing/batch_join/mul/y"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/batch_join/fraction_of_2048_full/tags"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "batch_processing/batch_join/fraction_of_2048_full"
      }
    }
  }
}
node {
  name: "batch_processing/batch_join/fraction_of_2048_full"
  op: "ScalarSummary"
  input: "batch_processing/batch_join/fraction_of_2048_full/tags"
  input: "batch_processing/batch_join/mul"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "batch_processing/batch_join/n"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 256
      }
    }
  }
}
node {
  name: "batch_processing/batch_join"
  op: "QueueDequeueManyV2"
  input: "batch_processing/batch_join/fifo_queue"
  input: "batch_processing/batch_join/n"
  device: "/device:CPU:0"
  attr {
    key: "component_types"
    value {
      list {
        type: DT_FLOAT
        type: DT_INT32
        type: DT_STRING
      }
    }
  }
  attr {
    key: "timeout_ms"
    value {
      i: -1
    }
  }
}
node {
  name: "batch_processing/Reshape/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\000\001\000\000\343\000\000\000\343\000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "batch_processing/Reshape"
  op: "Reshape"
  input: "batch_processing/batch_join"
  input: "batch_processing/Reshape/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "batch_processing/images/tag"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "batch_processing/images"
      }
    }
  }
}
node {
  name: "batch_processing/images"
  op: "ImageSummary"
  input: "batch_processing/images/tag"
  input: "batch_processing/Reshape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "bad_color"
    value {
      tensor {
        dtype: DT_UINT8
        tensor_shape {
          dim {
            size: 4
          }
        }
        int_val: 255
        int_val: 0
        int_val: 0
        int_val: 255
      }
    }
  }
  attr {
    key: "max_images"
    value {
      i: 20
    }
  }
}
node {
  name: "batch_processing/Reshape_1/shape"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 256
      }
    }
  }
}
node {
  name: "batch_processing/Reshape_1"
  op: "Reshape"
  input: "batch_processing/batch_join:1"
  input: "batch_processing/Reshape_1/shape"
  device: "/device:CPU:0"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\007\000\000\000\007\000\000\000\003\000\000\000`\000\000\000"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.009999999776482582
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "LeviHassnerBN/conv1/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "LeviHassnerBN/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  input: "LeviHassnerBN/conv1/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/weights/Initializer/random_normal"
  op: "Add"
  input: "LeviHassnerBN/conv1/weights/Initializer/random_normal/mul"
  input: "LeviHassnerBN/conv1/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 7
        }
        dim {
          size: 7
        }
        dim {
          size: 3
        }
        dim {
          size: 96
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/weights/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv1/weights"
  input: "LeviHassnerBN/conv1/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/weights/read"
  op: "Identity"
  input: "LeviHassnerBN/conv1/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/scale"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0005000000237487257
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/L2Loss"
  op: "L2Loss"
  input: "LeviHassnerBN/conv1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer"
  op: "Mul"
  input: "LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/scale"
  input: "LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/Conv2D"
  op: "Conv2D"
  input: "batch_processing/Reshape"
  input: "LeviHassnerBN/conv1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 4
        i: 4
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 96
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/beta/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 96
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 96
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/beta/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv1/BatchNorm/beta"
  input: "LeviHassnerBN/conv1/BatchNorm/beta/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/beta/read"
  op: "Identity"
  input: "LeviHassnerBN/conv1/BatchNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/beta"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/moving_mean/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 96
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/moving_mean"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 96
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/moving_mean/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_mean"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_mean/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/moving_mean/read"
  op: "Identity"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_mean"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/moving_variance/Initializer/ones"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 96
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/moving_variance"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 96
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/moving_variance/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_variance"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_variance/Initializer/ones"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/moving_variance/read"
  op: "Identity"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_variance"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_variance"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/Const_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm"
  op: "FusedBatchNorm"
  input: "LeviHassnerBN/conv1/Conv2D"
  input: "LeviHassnerBN/conv1/BatchNorm/Const"
  input: "LeviHassnerBN/conv1/BatchNorm/beta/read"
  input: "LeviHassnerBN/conv1/BatchNorm/Const_1"
  input: "LeviHassnerBN/conv1/BatchNorm/Const_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "epsilon"
    value {
      f: 0.0010000000474974513
    }
  }
  attr {
    key: "is_training"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/Const_3"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.9997000098228455
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg/sub/x"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg/sub"
  op: "Sub"
  input: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg/sub/x"
  input: "LeviHassnerBN/conv1/BatchNorm/Const_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_mean"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg/sub_1"
  op: "Sub"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_mean/read"
  input: "LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_mean"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg/mul"
  op: "Mul"
  input: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg/sub_1"
  input: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_mean"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg"
  op: "AssignSub"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_mean"
  input: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg_1/sub/x"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg_1/sub"
  op: "Sub"
  input: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg_1/sub/x"
  input: "LeviHassnerBN/conv1/BatchNorm/Const_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_variance"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg_1/sub_1"
  op: "Sub"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_variance/read"
  input: "LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm:2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_variance"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg_1/mul"
  op: "Mul"
  input: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg_1/sub_1"
  input: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg_1/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_variance"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg_1"
  op: "AssignSub"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_variance"
  input: "LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg_1/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "LeviHassnerBN/conv1/Relu"
  op: "Relu"
  input: "LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/pool1/MaxPool"
  op: "MaxPool"
  input: "LeviHassnerBN/conv1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 3
        i: 3
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\005\000\000\000\005\000\000\000`\000\000\000\000\001\000\000"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.009999999776482582
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "LeviHassnerBN/conv2/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "LeviHassnerBN/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  input: "LeviHassnerBN/conv2/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/weights/Initializer/random_normal"
  op: "Add"
  input: "LeviHassnerBN/conv2/weights/Initializer/random_normal/mul"
  input: "LeviHassnerBN/conv2/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 5
        }
        dim {
          size: 5
        }
        dim {
          size: 96
        }
        dim {
          size: 256
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/weights/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv2/weights"
  input: "LeviHassnerBN/conv2/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/weights/read"
  op: "Identity"
  input: "LeviHassnerBN/conv2/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/scale"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0005000000237487257
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/L2Loss"
  op: "L2Loss"
  input: "LeviHassnerBN/conv2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer"
  op: "Mul"
  input: "LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/scale"
  input: "LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/Conv2D"
  op: "Conv2D"
  input: "LeviHassnerBN/pool1/MaxPool"
  input: "LeviHassnerBN/conv2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 256
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/beta/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 256
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 256
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/beta/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv2/BatchNorm/beta"
  input: "LeviHassnerBN/conv2/BatchNorm/beta/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/beta/read"
  op: "Identity"
  input: "LeviHassnerBN/conv2/BatchNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/beta"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/moving_mean/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 256
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/moving_mean"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 256
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/moving_mean/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_mean"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_mean/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/moving_mean/read"
  op: "Identity"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_mean"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/moving_variance/Initializer/ones"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 256
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/moving_variance"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 256
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/moving_variance/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_variance"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_variance/Initializer/ones"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/moving_variance/read"
  op: "Identity"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_variance"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_variance"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/Const_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm"
  op: "FusedBatchNorm"
  input: "LeviHassnerBN/conv2/Conv2D"
  input: "LeviHassnerBN/conv2/BatchNorm/Const"
  input: "LeviHassnerBN/conv2/BatchNorm/beta/read"
  input: "LeviHassnerBN/conv2/BatchNorm/Const_1"
  input: "LeviHassnerBN/conv2/BatchNorm/Const_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "epsilon"
    value {
      f: 0.0010000000474974513
    }
  }
  attr {
    key: "is_training"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/Const_3"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.9997000098228455
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg/sub/x"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg/sub"
  op: "Sub"
  input: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg/sub/x"
  input: "LeviHassnerBN/conv2/BatchNorm/Const_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_mean"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg/sub_1"
  op: "Sub"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_mean/read"
  input: "LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_mean"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg/mul"
  op: "Mul"
  input: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg/sub_1"
  input: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_mean"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg"
  op: "AssignSub"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_mean"
  input: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg_1/sub/x"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg_1/sub"
  op: "Sub"
  input: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg_1/sub/x"
  input: "LeviHassnerBN/conv2/BatchNorm/Const_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_variance"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg_1/sub_1"
  op: "Sub"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_variance/read"
  input: "LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm:2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_variance"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg_1/mul"
  op: "Mul"
  input: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg_1/sub_1"
  input: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg_1/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_variance"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg_1"
  op: "AssignSub"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_variance"
  input: "LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg_1/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "LeviHassnerBN/conv2/Relu"
  op: "Relu"
  input: "LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/pool2/MaxPool"
  op: "MaxPool"
  input: "LeviHassnerBN/conv2/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 3
        i: 3
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\000\001\000\000\200\001\000\000"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.009999999776482582
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "LeviHassnerBN/conv3/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "LeviHassnerBN/conv3/weights/Initializer/random_normal/RandomStandardNormal"
  input: "LeviHassnerBN/conv3/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/weights/Initializer/random_normal"
  op: "Add"
  input: "LeviHassnerBN/conv3/weights/Initializer/random_normal/mul"
  input: "LeviHassnerBN/conv3/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 256
        }
        dim {
          size: 384
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/weights/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv3/weights"
  input: "LeviHassnerBN/conv3/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/weights/read"
  op: "Identity"
  input: "LeviHassnerBN/conv3/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/scale"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0005000000237487257
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/L2Loss"
  op: "L2Loss"
  input: "LeviHassnerBN/conv3/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer"
  op: "Mul"
  input: "LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/scale"
  input: "LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/Conv2D"
  op: "Conv2D"
  input: "LeviHassnerBN/pool2/MaxPool"
  input: "LeviHassnerBN/conv3/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 384
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/beta/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 384
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 384
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/beta/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv3/BatchNorm/beta"
  input: "LeviHassnerBN/conv3/BatchNorm/beta/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/beta/read"
  op: "Identity"
  input: "LeviHassnerBN/conv3/BatchNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/beta"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/moving_mean/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 384
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/moving_mean"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 384
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/moving_mean/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_mean"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_mean/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/moving_mean/read"
  op: "Identity"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_mean"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/moving_variance/Initializer/ones"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 384
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/moving_variance"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 384
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/moving_variance/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_variance"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_variance/Initializer/ones"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/moving_variance/read"
  op: "Identity"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_variance"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_variance"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/Const_2"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm"
  op: "FusedBatchNorm"
  input: "LeviHassnerBN/conv3/Conv2D"
  input: "LeviHassnerBN/conv3/BatchNorm/Const"
  input: "LeviHassnerBN/conv3/BatchNorm/beta/read"
  input: "LeviHassnerBN/conv3/BatchNorm/Const_1"
  input: "LeviHassnerBN/conv3/BatchNorm/Const_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "epsilon"
    value {
      f: 0.0010000000474974513
    }
  }
  attr {
    key: "is_training"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/Const_3"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.9997000098228455
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg/sub/x"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg/sub"
  op: "Sub"
  input: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg/sub/x"
  input: "LeviHassnerBN/conv3/BatchNorm/Const_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_mean"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg/sub_1"
  op: "Sub"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_mean/read"
  input: "LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_mean"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg/mul"
  op: "Mul"
  input: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg/sub_1"
  input: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_mean"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg"
  op: "AssignSub"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_mean"
  input: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg_1/sub/x"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg_1/sub"
  op: "Sub"
  input: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg_1/sub/x"
  input: "LeviHassnerBN/conv3/BatchNorm/Const_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_variance"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg_1/sub_1"
  op: "Sub"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_variance/read"
  input: "LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm:2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_variance"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg_1/mul"
  op: "Mul"
  input: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg_1/sub_1"
  input: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg_1/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_variance"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg_1"
  op: "AssignSub"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_variance"
  input: "LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg_1/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "LeviHassnerBN/conv3/Relu"
  op: "Relu"
  input: "LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/pool3/MaxPool"
  op: "MaxPool"
  input: "LeviHassnerBN/conv3/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 3
        i: 3
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "LeviHassnerBN/reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\377\377\377\377\0006\000\000"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/reshape"
  op: "Reshape"
  input: "LeviHassnerBN/pool3/MaxPool"
  input: "LeviHassnerBN/reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "LeviHassnerBN/full1/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\0006\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full1/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full1/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.004999999888241291
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full1/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "LeviHassnerBN/full1/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "LeviHassnerBN/full1/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "LeviHassnerBN/full1/weights/Initializer/random_normal/RandomStandardNormal"
  input: "LeviHassnerBN/full1/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full1/weights/Initializer/random_normal"
  op: "Add"
  input: "LeviHassnerBN/full1/weights/Initializer/random_normal/mul"
  input: "LeviHassnerBN/full1/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full1/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 13824
        }
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/full1/weights/Assign"
  op: "Assign"
  input: "LeviHassnerBN/full1/weights"
  input: "LeviHassnerBN/full1/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/full1/weights/read"
  op: "Identity"
  input: "LeviHassnerBN/full1/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/scale"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0005000000237487257
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/L2Loss"
  op: "L2Loss"
  input: "LeviHassnerBN/full1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer"
  op: "Mul"
  input: "LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/scale"
  input: "LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/full1/biases/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full1/biases"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/full1/biases/Assign"
  op: "Assign"
  input: "LeviHassnerBN/full1/biases"
  input: "LeviHassnerBN/full1/biases/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/full1/biases/read"
  op: "Identity"
  input: "LeviHassnerBN/full1/biases"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/biases"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full1/MatMul"
  op: "MatMul"
  input: "LeviHassnerBN/reshape"
  input: "LeviHassnerBN/full1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "LeviHassnerBN/full1/BiasAdd"
  op: "BiasAdd"
  input: "LeviHassnerBN/full1/MatMul"
  input: "LeviHassnerBN/full1/biases/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "LeviHassnerBN/full1/Relu"
  op: "Relu"
  input: "LeviHassnerBN/full1/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/full2/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\002\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full2/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full2/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.004999999888241291
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full2/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "LeviHassnerBN/full2/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "LeviHassnerBN/full2/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "LeviHassnerBN/full2/weights/Initializer/random_normal/RandomStandardNormal"
  input: "LeviHassnerBN/full2/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full2/weights/Initializer/random_normal"
  op: "Add"
  input: "LeviHassnerBN/full2/weights/Initializer/random_normal/mul"
  input: "LeviHassnerBN/full2/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full2/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/full2/weights/Assign"
  op: "Assign"
  input: "LeviHassnerBN/full2/weights"
  input: "LeviHassnerBN/full2/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/full2/weights/read"
  op: "Identity"
  input: "LeviHassnerBN/full2/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/scale"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0005000000237487257
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/L2Loss"
  op: "L2Loss"
  input: "LeviHassnerBN/full2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer"
  op: "Mul"
  input: "LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/scale"
  input: "LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "LeviHassnerBN/full2/biases/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full2/biases"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "LeviHassnerBN/full2/biases/Assign"
  op: "Assign"
  input: "LeviHassnerBN/full2/biases"
  input: "LeviHassnerBN/full2/biases/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "LeviHassnerBN/full2/biases/read"
  op: "Identity"
  input: "LeviHassnerBN/full2/biases"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/biases"
      }
    }
  }
}
node {
  name: "LeviHassnerBN/full2/MatMul"
  op: "MatMul"
  input: "LeviHassnerBN/full1/Relu"
  input: "LeviHassnerBN/full2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "LeviHassnerBN/full2/BiasAdd"
  op: "BiasAdd"
  input: "LeviHassnerBN/full2/MatMul"
  input: "LeviHassnerBN/full2/biases/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "LeviHassnerBN/full2/Relu"
  op: "Relu"
  input: "LeviHassnerBN/full2/BiasAdd"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "output/random_normal/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\002\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "output/random_normal/mean"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "output/random_normal/stddev"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.009999999776482582
      }
    }
  }
}
node {
  name: "output/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "output/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "output/random_normal/mul"
  op: "Mul"
  input: "output/random_normal/RandomStandardNormal"
  input: "output/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "output/random_normal"
  op: "Add"
  input: "output/random_normal/mul"
  input: "output/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "output/weights"
  op: "VariableV2"
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
        dim {
          size: 2
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "output/weights/Assign"
  op: "Assign"
  input: "output/weights"
  input: "output/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "output/weights/read"
  op: "Identity"
  input: "output/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
}
node {
  name: "output/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 2
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "output/biases"
  op: "VariableV2"
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 2
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "output/biases/Assign"
  op: "Assign"
  input: "output/biases"
  input: "output/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "output/biases/read"
  op: "Identity"
  input: "output/biases"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
}
node {
  name: "output/MatMul"
  op: "MatMul"
  input: "LeviHassnerBN/full2/Relu"
  input: "output/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "output/output"
  op: "Add"
  input: "output/MatMul"
  input: "output/biases/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "cross_entropy_per_example/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 256
      }
    }
  }
}
node {
  name: "cross_entropy_per_example/cross_entropy_per_example"
  op: "SparseSoftmaxCrossEntropyWithLogits"
  input: "output/output"
  input: "batch_processing/Reshape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tlabels"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "cross_entropy"
  op: "Mean"
  input: "cross_entropy_per_example/cross_entropy_per_example"
  input: "Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "add/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "add"
  op: "Add"
  input: "add/x"
  input: "LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_1"
  op: "Add"
  input: "add"
  input: "LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_2"
  op: "Add"
  input: "add_1"
  input: "LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_3"
  op: "Add"
  input: "add_2"
  input: "LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_4"
  op: "Add"
  input: "add_3"
  input: "LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.009999999776482582
      }
    }
  }
}
node {
  name: "mul"
  op: "Mul"
  input: "mul/x"
  input: "add_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_5"
  op: "Add"
  input: "cross_entropy"
  input: "mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "tl__raw_/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "tl__raw_"
      }
    }
  }
}
node {
  name: "tl__raw_"
  op: "ScalarSummary"
  input: "tl__raw_/tags"
  input: "add_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "cross_entropy/avg/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "cross_entropy/avg"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "cross_entropy/avg/Assign"
  op: "Assign"
  input: "cross_entropy/avg"
  input: "cross_entropy/avg/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "cross_entropy/avg/read"
  op: "Identity"
  input: "cross_entropy/avg"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
}
node {
  name: "add_5/avg/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "add_5/avg"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "add_5/avg/Assign"
  op: "Assign"
  input: "add_5/avg"
  input: "add_5/avg/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "add_5/avg/read"
  op: "Identity"
  input: "add_5/avg"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
}
node {
  name: "avg/decay"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.8999999761581421
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg/sub/x"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg/sub"
  op: "Sub"
  input: "avg/AssignMovingAvg/sub/x"
  input: "avg/decay"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg/sub_1"
  op: "Sub"
  input: "cross_entropy/avg/read"
  input: "cross_entropy"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg/mul"
  op: "Mul"
  input: "avg/AssignMovingAvg/sub_1"
  input: "avg/AssignMovingAvg/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg"
  op: "AssignSub"
  input: "cross_entropy/avg"
  input: "avg/AssignMovingAvg/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "avg/AssignMovingAvg_1/sub/x"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg_1/sub"
  op: "Sub"
  input: "avg/AssignMovingAvg_1/sub/x"
  input: "avg/decay"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg_1/sub_1"
  op: "Sub"
  input: "add_5/avg/read"
  input: "add_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg_1/mul"
  op: "Mul"
  input: "avg/AssignMovingAvg_1/sub_1"
  input: "avg/AssignMovingAvg_1/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
}
node {
  name: "avg/AssignMovingAvg_1"
  op: "AssignSub"
  input: "add_5/avg"
  input: "avg/AssignMovingAvg_1/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "avg"
  op: "NoOp"
  input: "^avg/AssignMovingAvg"
  input: "^avg/AssignMovingAvg_1"
}
node {
  name: "cross_entropy__raw_/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "cross_entropy__raw_"
      }
    }
  }
}
node {
  name: "cross_entropy__raw_"
  op: "ScalarSummary"
  input: "cross_entropy__raw_/tags"
  input: "cross_entropy"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "cross_entropy_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "cross_entropy_1"
      }
    }
  }
}
node {
  name: "cross_entropy_1"
  op: "ScalarSummary"
  input: "cross_entropy_1/tags"
  input: "cross_entropy/avg/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_5__raw_/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "add_5__raw_"
      }
    }
  }
}
node {
  name: "add_5__raw_"
  op: "ScalarSummary"
  input: "add_5__raw_/tags"
  input: "add_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "add_5_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "add_5_1"
      }
    }
  }
}
node {
  name: "add_5_1"
  op: "ScalarSummary"
  input: "add_5_1/tags"
  input: "add_5/avg/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "Identity"
  op: "Identity"
  input: "add_5"
  input: "^avg"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "Variable/initial_value"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "Variable"
  op: "VariableV2"
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "Variable/Assign"
  op: "Assign"
  input: "Variable"
  input: "Variable/initial_value"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "Variable/read"
  op: "Identity"
  input: "Variable"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Variable"
      }
    }
  }
}
node {
  name: "OptimizeLoss/control_dependency"
  op: "Identity"
  input: "Identity"
  input: "^LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg"
  input: "^LeviHassnerBN/conv1/BatchNorm/AssignMovingAvg_1"
  input: "^LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg"
  input: "^LeviHassnerBN/conv2/BatchNorm/AssignMovingAvg_1"
  input: "^LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg"
  input: "^LeviHassnerBN/conv3/BatchNorm/AssignMovingAvg_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Identity"
      }
    }
  }
}
node {
  name: "OptimizeLoss/learning_rate/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/learning_rate"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.009999999776482582
      }
    }
  }
}
node {
  name: "OptimizeLoss/learning_rate"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/learning_rate"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/learning_rate/Assign"
  op: "Assign"
  input: "OptimizeLoss/learning_rate"
  input: "OptimizeLoss/learning_rate/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/learning_rate"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/learning_rate/read"
  op: "Identity"
  input: "OptimizeLoss/learning_rate"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/learning_rate"
      }
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/Cast/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 8000
      }
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/Cast"
  op: "Cast"
  input: "OptimizeLoss/ExponentialDecay/Cast/x"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/Cast_1/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.30000001192092896
      }
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/Cast_2"
  op: "Cast"
  input: "Variable/read"
  attr {
    key: "DstT"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "SrcT"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "Truncate"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/truediv"
  op: "RealDiv"
  input: "OptimizeLoss/ExponentialDecay/Cast_2"
  input: "OptimizeLoss/ExponentialDecay/Cast"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/Floor"
  op: "Floor"
  input: "OptimizeLoss/ExponentialDecay/truediv"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay/Pow"
  op: "Pow"
  input: "OptimizeLoss/ExponentialDecay/Cast_1/x"
  input: "OptimizeLoss/ExponentialDecay/Floor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/ExponentialDecay"
  op: "Mul"
  input: "OptimizeLoss/learning_rate/read"
  input: "OptimizeLoss/ExponentialDecay/Pow"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/learning_rate_1/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "OptimizeLoss/learning_rate_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/learning_rate_1"
  op: "ScalarSummary"
  input: "OptimizeLoss/learning_rate_1/tags"
  input: "OptimizeLoss/ExponentialDecay"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
          }
        }
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/grad_ys_0"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/Fill"
  op: "Fill"
  input: "OptimizeLoss/gradients/Shape"
  input: "OptimizeLoss/gradients/grad_ys_0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/Fill"
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/Fill"
  input: "^OptimizeLoss/gradients/add_5_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/Fill"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_5_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/Fill"
  input: "^OptimizeLoss/gradients/add_5_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/Fill"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/add_5_grad/tuple/control_dependency"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 256
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Tile"
  op: "Tile"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Reshape"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tmultiples"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 256.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_grad/truediv"
  op: "RealDiv"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Tile"
  input: "OptimizeLoss/gradients/cross_entropy_grad/Const_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/Mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_5_grad/tuple/control_dependency_1"
  input: "add_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/Mul_1"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_5_grad/tuple/control_dependency_1"
  input: "mul/x"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/mul_grad/Mul"
  input: "^OptimizeLoss/gradients/mul_grad/Mul_1"
}
node {
  name: "OptimizeLoss/gradients/mul_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/mul_grad/Mul"
  input: "^OptimizeLoss/gradients/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/mul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/mul_grad/Mul_1"
  input: "^OptimizeLoss/gradients/mul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like"
  op: "ZerosLike"
  input: "cross_entropy_per_example/cross_entropy_per_example:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/PreventGradient"
  op: "PreventGradient"
  input: "cross_entropy_per_example/cross_entropy_per_example:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "message"
    value {
      s: "Currently there is no way to take the second derivative of sparse_softmax_cross_entropy_with_logits due to the fused implementation\'s interaction with tf.gradients()"
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: -1
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/ExpandDims"
  op: "ExpandDims"
  input: "OptimizeLoss/gradients/cross_entropy_grad/truediv"
  input: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/ExpandDims"
  input: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/PreventGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/mul_grad/tuple/control_dependency_1"
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/mul_grad/tuple/control_dependency_1"
  input: "^OptimizeLoss/gradients/add_4_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_4_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/mul_grad/tuple/control_dependency_1"
  input: "^OptimizeLoss/gradients/add_4_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\001\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/Shape_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 2
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/BroadcastGradientArgs"
  op: "BroadcastGradientArgs"
  input: "OptimizeLoss/gradients/output/output_grad/Shape"
  input: "OptimizeLoss/gradients/output/output_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/Sum"
  op: "Sum"
  input: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/mul"
  input: "OptimizeLoss/gradients/output/output_grad/BroadcastGradientArgs"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/output/output_grad/Sum"
  input: "OptimizeLoss/gradients/output/output_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/Sum_1"
  op: "Sum"
  input: "OptimizeLoss/gradients/cross_entropy_per_example/cross_entropy_per_example_grad/mul"
  input: "OptimizeLoss/gradients/output/output_grad/BroadcastGradientArgs:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/Reshape_1"
  op: "Reshape"
  input: "OptimizeLoss/gradients/output/output_grad/Sum_1"
  input: "OptimizeLoss/gradients/output/output_grad/Shape_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/output/output_grad/Reshape"
  input: "^OptimizeLoss/gradients/output/output_grad/Reshape_1"
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/output/output_grad/Reshape"
  input: "^OptimizeLoss/gradients/output/output_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/output_grad/Reshape"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/output/output_grad/Reshape_1"
  input: "^OptimizeLoss/gradients/output/output_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/output_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/add_4_grad/tuple/control_dependency"
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_4_grad/tuple/control_dependency"
  input: "^OptimizeLoss/gradients/add_3_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_3_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_4_grad/tuple/control_dependency"
  input: "^OptimizeLoss/gradients/add_3_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/Mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_4_grad/tuple/control_dependency_1"
  input: "LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/Mul_1"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_4_grad/tuple/control_dependency_1"
  input: "LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/scale"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/Mul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/Mul_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/Mul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/Mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/Mul_1"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/MatMul_grad/MatMul"
  op: "MatMul"
  input: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency"
  input: "output/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "LeviHassnerBN/full2/Relu"
  input: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: true
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/output/MatMul_grad/MatMul"
  input: "^OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
}
node {
  name: "OptimizeLoss/gradients/output/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/output/MatMul_grad/MatMul"
  input: "^OptimizeLoss/gradients/output/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/output/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
  input: "^OptimizeLoss/gradients/output/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/add_3_grad/tuple/control_dependency"
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_3_grad/tuple/control_dependency"
  input: "^OptimizeLoss/gradients/add_2_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_2_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_3_grad/tuple/control_dependency"
  input: "^OptimizeLoss/gradients/add_2_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/Mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_3_grad/tuple/control_dependency_1"
  input: "LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/Mul_1"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_3_grad/tuple/control_dependency_1"
  input: "LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/scale"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/Mul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/Mul_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/Mul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/Mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/Mul_1"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  op: "Mul"
  input: "LeviHassnerBN/full2/weights/read"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "OptimizeLoss/gradients/output/MatMul_grad/tuple/control_dependency"
  input: "LeviHassnerBN/full2/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/add_2_grad/tuple/control_dependency"
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_2_grad/tuple/control_dependency"
  input: "^OptimizeLoss/gradients/add_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_1_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_2_grad/tuple/control_dependency"
  input: "^OptimizeLoss/gradients/add_1_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/Mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_2_grad/tuple/control_dependency_1"
  input: "LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/Mul_1"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_2_grad/tuple/control_dependency_1"
  input: "LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/scale"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/Mul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/Mul_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/Mul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/Mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/Mul_1"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  op: "Mul"
  input: "LeviHassnerBN/full1/weights/read"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/BiasAddGrad"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full2/Relu_grad/ReluGrad"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/Relu_grad/ReluGrad"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/BiasAddGrad"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/add_1_grad/tuple/control_dependency"
}
node {
  name: "OptimizeLoss/gradients/add_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_1_grad/tuple/control_dependency"
  input: "^OptimizeLoss/gradients/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/add_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/add_1_grad/tuple/control_dependency"
  input: "^OptimizeLoss/gradients/add_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/mul_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/Mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_1_grad/tuple/control_dependency_1"
  input: "LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/Mul_1"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_1_grad/tuple/control_dependency_1"
  input: "LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/scale"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/Mul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/Mul_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/Mul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/Mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/Mul_1"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  op: "Mul"
  input: "LeviHassnerBN/conv3/weights/read"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/MatMul"
  op: "MatMul"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/tuple/control_dependency"
  input: "LeviHassnerBN/full2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "LeviHassnerBN/full1/Relu"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: true
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/MatMul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/MatMul_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/MatMul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/MatMul_1"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/Mul"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_grad/tuple/control_dependency_1"
  input: "LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/L2Loss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/Mul_1"
  op: "Mul"
  input: "OptimizeLoss/gradients/add_grad/tuple/control_dependency_1"
  input: "LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/scale"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/Mul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/Mul_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/Mul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/Mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/Mul_1"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/Mul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  op: "Mul"
  input: "LeviHassnerBN/conv2/weights/read"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/tuple/control_dependency"
  input: "LeviHassnerBN/full1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/AddN"
  op: "AddN"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  op: "Mul"
  input: "LeviHassnerBN/conv1/weights/read"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/BiasAddGrad"
  op: "BiasAddGrad"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/Relu_grad/ReluGrad"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/BiasAddGrad"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full1/Relu_grad/ReluGrad"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/Relu_grad/ReluGrad"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/Relu_grad/ReluGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/BiasAddGrad"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/MatMul"
  op: "MatMul"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/tuple/control_dependency"
  input: "LeviHassnerBN/full1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: false
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/MatMul_1"
  op: "MatMul"
  input: "LeviHassnerBN/reshape"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "transpose_a"
    value {
      b: true
    }
  }
  attr {
    key: "transpose_b"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/MatMul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/MatMul_1"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/MatMul"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/MatMul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/MatMul_1"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/reshape_grad/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\000\001\000\000\006\000\000\000\006\000\000\000\200\001\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/reshape_grad/Reshape"
  op: "Reshape"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/tuple/control_dependency"
  input: "OptimizeLoss/gradients/LeviHassnerBN/reshape_grad/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/AddN_1"
  op: "AddN"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/pool3/MaxPool_grad/MaxPoolGrad"
  op: "MaxPoolGrad"
  input: "LeviHassnerBN/conv3/Relu"
  input: "LeviHassnerBN/pool3/MaxPool"
  input: "OptimizeLoss/gradients/LeviHassnerBN/reshape_grad/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 3
        i: 3
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "OptimizeLoss/gradients/LeviHassnerBN/pool3/MaxPool_grad/MaxPoolGrad"
  input: "LeviHassnerBN/conv3/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like_1"
  op: "ZerosLike"
  input: "LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like_2"
  op: "ZerosLike"
  input: "LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm:2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like_3"
  op: "ZerosLike"
  input: "LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm:3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like_4"
  op: "ZerosLike"
  input: "LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm:4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
  op: "FusedBatchNormGrad"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Relu_grad/ReluGrad"
  input: "LeviHassnerBN/conv3/Conv2D"
  input: "LeviHassnerBN/conv3/BatchNorm/Const"
  input: "LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm:3"
  input: "LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm:4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "epsilon"
    value {
      f: 0.0010000000474974513
    }
  }
  attr {
    key: "is_training"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad:1"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_2"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad:2"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_3"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad:3"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_4"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad:4"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/ShapeN"
  op: "ShapeN"
  input: "LeviHassnerBN/pool2/MaxPool"
  input: "LeviHassnerBN/conv3/weights/read"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/Conv2DBackpropInput"
  op: "Conv2DBackpropInput"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/ShapeN"
  input: "LeviHassnerBN/conv3/weights/read"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/Conv2DBackpropFilter"
  op: "Conv2DBackpropFilter"
  input: "LeviHassnerBN/pool2/MaxPool"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/ShapeN:1"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/Conv2DBackpropFilter"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/Conv2DBackpropInput"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/Conv2DBackpropInput"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/Conv2DBackpropInput"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/Conv2DBackpropFilter"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/Conv2DBackpropFilter"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/pool2/MaxPool_grad/MaxPoolGrad"
  op: "MaxPoolGrad"
  input: "LeviHassnerBN/conv2/Relu"
  input: "LeviHassnerBN/pool2/MaxPool"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 3
        i: 3
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/AddN_2"
  op: "AddN"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/Conv2D_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "OptimizeLoss/gradients/LeviHassnerBN/pool2/MaxPool_grad/MaxPoolGrad"
  input: "LeviHassnerBN/conv2/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like_5"
  op: "ZerosLike"
  input: "LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like_6"
  op: "ZerosLike"
  input: "LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm:2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like_7"
  op: "ZerosLike"
  input: "LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm:3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like_8"
  op: "ZerosLike"
  input: "LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm:4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
  op: "FusedBatchNormGrad"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Relu_grad/ReluGrad"
  input: "LeviHassnerBN/conv2/Conv2D"
  input: "LeviHassnerBN/conv2/BatchNorm/Const"
  input: "LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm:3"
  input: "LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm:4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "epsilon"
    value {
      f: 0.0010000000474974513
    }
  }
  attr {
    key: "is_training"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad:1"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_2"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad:2"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_3"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad:3"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_4"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad:4"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/ShapeN"
  op: "ShapeN"
  input: "LeviHassnerBN/pool1/MaxPool"
  input: "LeviHassnerBN/conv2/weights/read"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/Conv2DBackpropInput"
  op: "Conv2DBackpropInput"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/ShapeN"
  input: "LeviHassnerBN/conv2/weights/read"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/Conv2DBackpropFilter"
  op: "Conv2DBackpropFilter"
  input: "LeviHassnerBN/pool1/MaxPool"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/ShapeN:1"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "SAME"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/Conv2DBackpropFilter"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/Conv2DBackpropInput"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/Conv2DBackpropInput"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/Conv2DBackpropInput"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/Conv2DBackpropFilter"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/Conv2DBackpropFilter"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/pool1/MaxPool_grad/MaxPoolGrad"
  op: "MaxPoolGrad"
  input: "LeviHassnerBN/conv1/Relu"
  input: "LeviHassnerBN/pool1/MaxPool"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "ksize"
    value {
      list {
        i: 1
        i: 3
        i: 3
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/AddN_3"
  op: "AddN"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/Conv2D_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Relu_grad/ReluGrad"
  op: "ReluGrad"
  input: "OptimizeLoss/gradients/LeviHassnerBN/pool1/MaxPool_grad/MaxPoolGrad"
  input: "LeviHassnerBN/conv1/Relu"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like_9"
  op: "ZerosLike"
  input: "LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like_10"
  op: "ZerosLike"
  input: "LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm:2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like_11"
  op: "ZerosLike"
  input: "LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm:3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/zeros_like_12"
  op: "ZerosLike"
  input: "LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm:4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
  op: "FusedBatchNormGrad"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Relu_grad/ReluGrad"
  input: "LeviHassnerBN/conv1/Conv2D"
  input: "LeviHassnerBN/conv1/BatchNorm/Const"
  input: "LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm:3"
  input: "LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm:4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "epsilon"
    value {
      f: 0.0010000000474974513
    }
  }
  attr {
    key: "is_training"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad:1"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_2"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad:2"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_3"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad:3"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_4"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad:4"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/ShapeN"
  op: "ShapeN"
  input: "batch_processing/Reshape"
  input: "LeviHassnerBN/conv1/weights/read"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/Conv2DBackpropInput"
  op: "Conv2DBackpropInput"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/ShapeN"
  input: "LeviHassnerBN/conv1/weights/read"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 4
        i: 4
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/Conv2DBackpropFilter"
  op: "Conv2DBackpropFilter"
  input: "batch_processing/Reshape"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/ShapeN:1"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "dilations"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 4
        i: 4
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/tuple/group_deps"
  op: "NoOp"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/Conv2DBackpropFilter"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/Conv2DBackpropInput"
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/tuple/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/Conv2DBackpropInput"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/Conv2DBackpropInput"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/tuple/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/Conv2DBackpropFilter"
  input: "^OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/tuple/group_deps"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/Conv2DBackpropFilter"
      }
    }
  }
}
node {
  name: "OptimizeLoss/gradients/AddN_4"
  op: "AddN"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/Conv2D_grad/tuple/control_dependency_1"
  attr {
    key: "N"
    value {
      i: 2
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_1"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_2"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_3"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_4"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_5"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_6"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_7"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_8"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_9"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_10"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/output/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/L2Loss_11"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/output_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/stack"
  op: "Pack"
  input: "OptimizeLoss/global_norm/L2Loss"
  input: "OptimizeLoss/global_norm/L2Loss_1"
  input: "OptimizeLoss/global_norm/L2Loss_2"
  input: "OptimizeLoss/global_norm/L2Loss_3"
  input: "OptimizeLoss/global_norm/L2Loss_4"
  input: "OptimizeLoss/global_norm/L2Loss_5"
  input: "OptimizeLoss/global_norm/L2Loss_6"
  input: "OptimizeLoss/global_norm/L2Loss_7"
  input: "OptimizeLoss/global_norm/L2Loss_8"
  input: "OptimizeLoss/global_norm/L2Loss_9"
  input: "OptimizeLoss/global_norm/L2Loss_10"
  input: "OptimizeLoss/global_norm/L2Loss_11"
  attr {
    key: "N"
    value {
      i: 12
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/Sum"
  op: "Sum"
  input: "OptimizeLoss/global_norm/stack"
  input: "OptimizeLoss/global_norm/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/mul"
  op: "Mul"
  input: "OptimizeLoss/global_norm/Sum"
  input: "OptimizeLoss/global_norm/Const_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/global_norm"
  op: "Sqrt"
  input: "OptimizeLoss/global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/gradient_norm/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "OptimizeLoss/global_norm/gradient_norm"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/gradient_norm"
  op: "ScalarSummary"
  input: "OptimizeLoss/global_norm/gradient_norm/tags"
  input: "OptimizeLoss/global_norm/global_norm"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/L2Loss"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/L2Loss_1"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/L2Loss_2"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/L2Loss_3"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/L2Loss_4"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/L2Loss_5"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/L2Loss_6"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/L2Loss_7"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/L2Loss_8"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/AddN"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/L2Loss_9"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/L2Loss_10"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/output/MatMul_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/L2Loss_11"
  op: "L2Loss"
  input: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/output_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/stack"
  op: "Pack"
  input: "OptimizeLoss/global_norm_1/L2Loss"
  input: "OptimizeLoss/global_norm_1/L2Loss_1"
  input: "OptimizeLoss/global_norm_1/L2Loss_2"
  input: "OptimizeLoss/global_norm_1/L2Loss_3"
  input: "OptimizeLoss/global_norm_1/L2Loss_4"
  input: "OptimizeLoss/global_norm_1/L2Loss_5"
  input: "OptimizeLoss/global_norm_1/L2Loss_6"
  input: "OptimizeLoss/global_norm_1/L2Loss_7"
  input: "OptimizeLoss/global_norm_1/L2Loss_8"
  input: "OptimizeLoss/global_norm_1/L2Loss_9"
  input: "OptimizeLoss/global_norm_1/L2Loss_10"
  input: "OptimizeLoss/global_norm_1/L2Loss_11"
  attr {
    key: "N"
    value {
      i: 12
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/Sum"
  op: "Sum"
  input: "OptimizeLoss/global_norm_1/stack"
  input: "OptimizeLoss/global_norm_1/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/mul"
  op: "Mul"
  input: "OptimizeLoss/global_norm_1/Sum"
  input: "OptimizeLoss/global_norm_1/Const_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_1/global_norm"
  op: "Sqrt"
  input: "OptimizeLoss/global_norm_1/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/VerifyFinite/CheckNumerics"
  op: "CheckNumerics"
  input: "OptimizeLoss/global_norm_1/global_norm"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/global_norm_1/global_norm"
      }
    }
  }
  attr {
    key: "message"
    value {
      s: "Found Inf or NaN global norm."
    }
  }
}
node {
  name: "OptimizeLoss/VerifyFinite/control_dependency"
  op: "Identity"
  input: "OptimizeLoss/global_norm_1/global_norm"
  input: "^OptimizeLoss/VerifyFinite/CheckNumerics"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/global_norm_1/global_norm"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/truediv/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/truediv"
  op: "RealDiv"
  input: "OptimizeLoss/clip_by_global_norm/truediv/x"
  input: "OptimizeLoss/VerifyFinite/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/truediv_1/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 4.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/truediv_1"
  op: "RealDiv"
  input: "OptimizeLoss/clip_by_global_norm/Const"
  input: "OptimizeLoss/clip_by_global_norm/truediv_1/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/Minimum"
  op: "Minimum"
  input: "OptimizeLoss/clip_by_global_norm/truediv"
  input: "OptimizeLoss/clip_by_global_norm/truediv_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul/x"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 4.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul"
  op: "Mul"
  input: "OptimizeLoss/clip_by_global_norm/mul/x"
  input: "OptimizeLoss/clip_by_global_norm/Minimum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_1"
  op: "Mul"
  input: "OptimizeLoss/gradients/AddN_4"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_0"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_2"
  op: "Mul"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_2"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_1"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_3"
  op: "Mul"
  input: "OptimizeLoss/gradients/AddN_3"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_2"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_4"
  op: "Mul"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_2"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_3"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_5"
  op: "Mul"
  input: "OptimizeLoss/gradients/AddN_2"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_4"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_6"
  op: "Mul"
  input: "OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/tuple/control_dependency_2"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_5"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_6"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_7"
  op: "Mul"
  input: "OptimizeLoss/gradients/AddN_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_6"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_7"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_8"
  op: "Mul"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_7"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_8"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_9"
  op: "Mul"
  input: "OptimizeLoss/gradients/AddN"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_8"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_9"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_10"
  op: "Mul"
  input: "OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_9"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_10"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_11"
  op: "Mul"
  input: "OptimizeLoss/gradients/output/MatMul_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_10"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_11"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/mul_12"
  op: "Mul"
  input: "OptimizeLoss/gradients/output/output_grad/tuple/control_dependency_1"
  input: "OptimizeLoss/clip_by_global_norm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/output_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_11"
  op: "Identity"
  input: "OptimizeLoss/clip_by_global_norm/mul_12"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/output_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/loss/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "OptimizeLoss/loss"
      }
    }
  }
}
node {
  name: "OptimizeLoss/loss"
  op: "ScalarSummary"
  input: "OptimizeLoss/loss/tags"
  input: "OptimizeLoss/control_dependency"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/L2Loss"
  op: "L2Loss"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_0"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/L2Loss_1"
  op: "L2Loss"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv1/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/L2Loss_2"
  op: "L2Loss"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/L2Loss_3"
  op: "L2Loss"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv2/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/L2Loss_4"
  op: "L2Loss"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/L2Loss_5"
  op: "L2Loss"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/conv3/BatchNorm/FusedBatchNorm_grad/FusedBatchNormGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/L2Loss_6"
  op: "L2Loss"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_6"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/L2Loss_7"
  op: "L2Loss"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_7"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full1/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/L2Loss_8"
  op: "L2Loss"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_8"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/kernel/Regularizer/l2_regularizer/L2Loss_grad/mul"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/L2Loss_9"
  op: "L2Loss"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_9"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/LeviHassnerBN/full2/BiasAdd_grad/BiasAddGrad"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/L2Loss_10"
  op: "L2Loss"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_10"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/MatMul_grad/MatMul_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/L2Loss_11"
  op: "L2Loss"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_11"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/gradients/output/output_grad/Reshape_1"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/stack"
  op: "Pack"
  input: "OptimizeLoss/global_norm_2/L2Loss"
  input: "OptimizeLoss/global_norm_2/L2Loss_1"
  input: "OptimizeLoss/global_norm_2/L2Loss_2"
  input: "OptimizeLoss/global_norm_2/L2Loss_3"
  input: "OptimizeLoss/global_norm_2/L2Loss_4"
  input: "OptimizeLoss/global_norm_2/L2Loss_5"
  input: "OptimizeLoss/global_norm_2/L2Loss_6"
  input: "OptimizeLoss/global_norm_2/L2Loss_7"
  input: "OptimizeLoss/global_norm_2/L2Loss_8"
  input: "OptimizeLoss/global_norm_2/L2Loss_9"
  input: "OptimizeLoss/global_norm_2/L2Loss_10"
  input: "OptimizeLoss/global_norm_2/L2Loss_11"
  attr {
    key: "N"
    value {
      i: 12
    }
  }
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "axis"
    value {
      i: 0
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 1
          }
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/Sum"
  op: "Sum"
  input: "OptimizeLoss/global_norm_2/stack"
  input: "OptimizeLoss/global_norm_2/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/Const_1"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 2.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/mul"
  op: "Mul"
  input: "OptimizeLoss/global_norm_2/Sum"
  input: "OptimizeLoss/global_norm_2/Const_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/global_norm_2/global_norm"
  op: "Sqrt"
  input: "OptimizeLoss/global_norm_2/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/clipped_gradient_norm/tags"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "OptimizeLoss/global_norm/clipped_gradient_norm"
      }
    }
  }
}
node {
  name: "OptimizeLoss/global_norm/clipped_gradient_norm"
  op: "ScalarSummary"
  input: "OptimizeLoss/global_norm/clipped_gradient_norm/tags"
  input: "OptimizeLoss/global_norm_2/global_norm"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\007\000\000\000\007\000\000\000\003\000\000\000`\000\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum/Initializer/zeros"
  op: "Fill"
  input: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum/Initializer/zeros/shape_as_tensor"
  input: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 7
        }
        dim {
          size: 7
        }
        dim {
          size: 3
        }
        dim {
          size: 96
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 96
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 96
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/beta"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\005\000\000\000\005\000\000\000`\000\000\000\000\001\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum/Initializer/zeros"
  op: "Fill"
  input: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum/Initializer/zeros/shape_as_tensor"
  input: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 5
        }
        dim {
          size: 5
        }
        dim {
          size: 96
        }
        dim {
          size: 256
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 256
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 256
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/beta"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\000\001\000\000\200\001\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum/Initializer/zeros"
  op: "Fill"
  input: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum/Initializer/zeros/shape_as_tensor"
  input: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 256
        }
        dim {
          size: 384
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 384
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 384
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/beta"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\0006\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum/Initializer/zeros"
  op: "Fill"
  input: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum/Initializer/zeros/shape_as_tensor"
  input: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 13824
        }
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full1/biases/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full1/biases/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full1/biases/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/full1/biases/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/full1/biases/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full1/biases/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassnerBN/full1/biases/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/biases"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\002\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum/Initializer/zeros"
  op: "Fill"
  input: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum/Initializer/zeros/shape_as_tensor"
  input: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full2/biases/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 512
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full2/biases/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full2/biases/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/full2/biases/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/full2/biases/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/LeviHassnerBN/full2/biases/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/LeviHassnerBN/full2/biases/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/biases"
      }
    }
  }
}
node {
  name: "OptimizeLoss/output/weights/Momentum/Initializer/zeros/shape_as_tensor"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\002\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "OptimizeLoss/output/weights/Momentum/Initializer/zeros/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/output/weights/Momentum/Initializer/zeros"
  op: "Fill"
  input: "OptimizeLoss/output/weights/Momentum/Initializer/zeros/shape_as_tensor"
  input: "OptimizeLoss/output/weights/Momentum/Initializer/zeros/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "index_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "OptimizeLoss/output/weights/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 512
        }
        dim {
          size: 2
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/output/weights/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/output/weights/Momentum"
  input: "OptimizeLoss/output/weights/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/output/weights/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/output/weights/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
}
node {
  name: "OptimizeLoss/output/biases/Momentum/Initializer/zeros"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 2
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "OptimizeLoss/output/biases/Momentum"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 2
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "OptimizeLoss/output/biases/Momentum/Assign"
  op: "Assign"
  input: "OptimizeLoss/output/biases/Momentum"
  input: "OptimizeLoss/output/biases/Momentum/Initializer/zeros"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "OptimizeLoss/output/biases/Momentum/read"
  op: "Identity"
  input: "OptimizeLoss/output/biases/Momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
}
node {
  name: "OptimizeLoss/train/momentum"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.8999999761581421
      }
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassnerBN/conv1/weights/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassnerBN/conv1/weights"
  input: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_0"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassnerBN/conv1/BatchNorm/beta/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassnerBN/conv1/BatchNorm/beta"
  input: "OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_1"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassnerBN/conv2/weights/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassnerBN/conv2/weights"
  input: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_2"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassnerBN/conv2/BatchNorm/beta/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassnerBN/conv2/BatchNorm/beta"
  input: "OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_3"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassnerBN/conv3/weights/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassnerBN/conv3/weights"
  input: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_4"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassnerBN/conv3/BatchNorm/beta/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassnerBN/conv3/BatchNorm/beta"
  input: "OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_5"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassnerBN/full1/weights/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassnerBN/full1/weights"
  input: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_6"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassnerBN/full1/biases/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassnerBN/full1/biases"
  input: "OptimizeLoss/LeviHassnerBN/full1/biases/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_7"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassnerBN/full2/weights/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassnerBN/full2/weights"
  input: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_8"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_LeviHassnerBN/full2/biases/ApplyMomentum"
  op: "ApplyMomentum"
  input: "LeviHassnerBN/full2/biases"
  input: "OptimizeLoss/LeviHassnerBN/full2/biases/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_9"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_output/weights/ApplyMomentum"
  op: "ApplyMomentum"
  input: "output/weights"
  input: "OptimizeLoss/output/weights/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_10"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update_output/biases/ApplyMomentum"
  op: "ApplyMomentum"
  input: "output/biases"
  input: "OptimizeLoss/output/biases/Momentum"
  input: "OptimizeLoss/ExponentialDecay"
  input: "OptimizeLoss/clip_by_global_norm/OptimizeLoss/clip_by_global_norm/_11"
  input: "OptimizeLoss/train/momentum"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
  attr {
    key: "use_nesterov"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/train/update"
  op: "NoOp"
  input: "^OptimizeLoss/train/update_LeviHassnerBN/conv1/BatchNorm/beta/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassnerBN/conv1/weights/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassnerBN/conv2/BatchNorm/beta/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassnerBN/conv2/weights/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassnerBN/conv3/BatchNorm/beta/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassnerBN/conv3/weights/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassnerBN/full1/biases/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassnerBN/full1/weights/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassnerBN/full2/biases/ApplyMomentum"
  input: "^OptimizeLoss/train/update_LeviHassnerBN/full2/weights/ApplyMomentum"
  input: "^OptimizeLoss/train/update_output/biases/ApplyMomentum"
  input: "^OptimizeLoss/train/update_output/weights/ApplyMomentum"
}
node {
  name: "OptimizeLoss/train/value"
  op: "Const"
  input: "^OptimizeLoss/train/update"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Variable"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "OptimizeLoss/train"
  op: "AssignAdd"
  input: "Variable"
  input: "OptimizeLoss/train/value"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: false
    }
  }
}
node {
  name: "OptimizeLoss/control_dependency_1"
  op: "Identity"
  input: "OptimizeLoss/control_dependency"
  input: "^OptimizeLoss/train"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Identity"
      }
    }
  }
}
node {
  name: "save/filename/input"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "model"
      }
    }
  }
}
node {
  name: "save/filename"
  op: "PlaceholderWithDefault"
  input: "save/filename/input"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "save/Const"
  op: "PlaceholderWithDefault"
  input: "save/filename"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "save/SaveV2/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 34
          }
        }
        string_val: "LeviHassnerBN/conv1/BatchNorm/beta"
        string_val: "LeviHassnerBN/conv1/BatchNorm/moving_mean"
        string_val: "LeviHassnerBN/conv1/BatchNorm/moving_variance"
        string_val: "LeviHassnerBN/conv1/weights"
        string_val: "LeviHassnerBN/conv2/BatchNorm/beta"
        string_val: "LeviHassnerBN/conv2/BatchNorm/moving_mean"
        string_val: "LeviHassnerBN/conv2/BatchNorm/moving_variance"
        string_val: "LeviHassnerBN/conv2/weights"
        string_val: "LeviHassnerBN/conv3/BatchNorm/beta"
        string_val: "LeviHassnerBN/conv3/BatchNorm/moving_mean"
        string_val: "LeviHassnerBN/conv3/BatchNorm/moving_variance"
        string_val: "LeviHassnerBN/conv3/weights"
        string_val: "LeviHassnerBN/full1/biases"
        string_val: "LeviHassnerBN/full1/weights"
        string_val: "LeviHassnerBN/full2/biases"
        string_val: "LeviHassnerBN/full2/weights"
        string_val: "OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/full1/biases/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/full2/biases/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum"
        string_val: "OptimizeLoss/learning_rate"
        string_val: "OptimizeLoss/output/biases/Momentum"
        string_val: "OptimizeLoss/output/weights/Momentum"
        string_val: "Variable"
        string_val: "add_5/avg"
        string_val: "cross_entropy/avg"
        string_val: "output/biases"
        string_val: "output/weights"
      }
    }
  }
}
node {
  name: "save/SaveV2/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 34
          }
        }
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
      }
    }
  }
}
node {
  name: "save/SaveV2"
  op: "SaveV2"
  input: "save/Const"
  input: "save/SaveV2/tensor_names"
  input: "save/SaveV2/shape_and_slices"
  input: "LeviHassnerBN/conv1/BatchNorm/beta"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_mean"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_variance"
  input: "LeviHassnerBN/conv1/weights"
  input: "LeviHassnerBN/conv2/BatchNorm/beta"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_mean"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_variance"
  input: "LeviHassnerBN/conv2/weights"
  input: "LeviHassnerBN/conv3/BatchNorm/beta"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_mean"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_variance"
  input: "LeviHassnerBN/conv3/weights"
  input: "LeviHassnerBN/full1/biases"
  input: "LeviHassnerBN/full1/weights"
  input: "LeviHassnerBN/full2/biases"
  input: "LeviHassnerBN/full2/weights"
  input: "OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/full1/biases/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/full2/biases/Momentum"
  input: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum"
  input: "OptimizeLoss/learning_rate"
  input: "OptimizeLoss/output/biases/Momentum"
  input: "OptimizeLoss/output/weights/Momentum"
  input: "Variable"
  input: "add_5/avg"
  input: "cross_entropy/avg"
  input: "output/biases"
  input: "output/weights"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_INT32
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/control_dependency"
  op: "Identity"
  input: "save/Const"
  input: "^save/SaveV2"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@save/Const"
      }
    }
  }
}
node {
  name: "save/RestoreV2/tensor_names"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 34
          }
        }
        string_val: "LeviHassnerBN/conv1/BatchNorm/beta"
        string_val: "LeviHassnerBN/conv1/BatchNorm/moving_mean"
        string_val: "LeviHassnerBN/conv1/BatchNorm/moving_variance"
        string_val: "LeviHassnerBN/conv1/weights"
        string_val: "LeviHassnerBN/conv2/BatchNorm/beta"
        string_val: "LeviHassnerBN/conv2/BatchNorm/moving_mean"
        string_val: "LeviHassnerBN/conv2/BatchNorm/moving_variance"
        string_val: "LeviHassnerBN/conv2/weights"
        string_val: "LeviHassnerBN/conv3/BatchNorm/beta"
        string_val: "LeviHassnerBN/conv3/BatchNorm/moving_mean"
        string_val: "LeviHassnerBN/conv3/BatchNorm/moving_variance"
        string_val: "LeviHassnerBN/conv3/weights"
        string_val: "LeviHassnerBN/full1/biases"
        string_val: "LeviHassnerBN/full1/weights"
        string_val: "LeviHassnerBN/full2/biases"
        string_val: "LeviHassnerBN/full2/weights"
        string_val: "OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/full1/biases/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/full2/biases/Momentum"
        string_val: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum"
        string_val: "OptimizeLoss/learning_rate"
        string_val: "OptimizeLoss/output/biases/Momentum"
        string_val: "OptimizeLoss/output/weights/Momentum"
        string_val: "Variable"
        string_val: "add_5/avg"
        string_val: "cross_entropy/avg"
        string_val: "output/biases"
        string_val: "output/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2/shape_and_slices"
  op: "Const"
  device: "/device:CPU:0"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 34
          }
        }
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2/tensor_names"
  input: "save/RestoreV2/shape_and_slices"
  device: "/device:CPU:0"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_INT32
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign"
  op: "Assign"
  input: "LeviHassnerBN/conv1/BatchNorm/beta"
  input: "save/RestoreV2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_1"
  op: "Assign"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_mean"
  input: "save/RestoreV2:1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_2"
  op: "Assign"
  input: "LeviHassnerBN/conv1/BatchNorm/moving_variance"
  input: "save/RestoreV2:2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_3"
  op: "Assign"
  input: "LeviHassnerBN/conv1/weights"
  input: "save/RestoreV2:3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_4"
  op: "Assign"
  input: "LeviHassnerBN/conv2/BatchNorm/beta"
  input: "save/RestoreV2:4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_5"
  op: "Assign"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_mean"
  input: "save/RestoreV2:5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_6"
  op: "Assign"
  input: "LeviHassnerBN/conv2/BatchNorm/moving_variance"
  input: "save/RestoreV2:6"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_7"
  op: "Assign"
  input: "LeviHassnerBN/conv2/weights"
  input: "save/RestoreV2:7"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_8"
  op: "Assign"
  input: "LeviHassnerBN/conv3/BatchNorm/beta"
  input: "save/RestoreV2:8"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_9"
  op: "Assign"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_mean"
  input: "save/RestoreV2:9"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_mean"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_10"
  op: "Assign"
  input: "LeviHassnerBN/conv3/BatchNorm/moving_variance"
  input: "save/RestoreV2:10"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/moving_variance"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_11"
  op: "Assign"
  input: "LeviHassnerBN/conv3/weights"
  input: "save/RestoreV2:11"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_12"
  op: "Assign"
  input: "LeviHassnerBN/full1/biases"
  input: "save/RestoreV2:12"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_13"
  op: "Assign"
  input: "LeviHassnerBN/full1/weights"
  input: "save/RestoreV2:13"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_14"
  op: "Assign"
  input: "LeviHassnerBN/full2/biases"
  input: "save/RestoreV2:14"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_15"
  op: "Assign"
  input: "LeviHassnerBN/full2/weights"
  input: "save/RestoreV2:15"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_16"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum"
  input: "save/RestoreV2:16"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_17"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum"
  input: "save/RestoreV2:17"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_18"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum"
  input: "save/RestoreV2:18"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_19"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum"
  input: "save/RestoreV2:19"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_20"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum"
  input: "save/RestoreV2:20"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/BatchNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_21"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum"
  input: "save/RestoreV2:21"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/conv3/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_22"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/full1/biases/Momentum"
  input: "save/RestoreV2:22"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_23"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/full1/weights/Momentum"
  input: "save/RestoreV2:23"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_24"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/full2/biases/Momentum"
  input: "save/RestoreV2:24"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_25"
  op: "Assign"
  input: "OptimizeLoss/LeviHassnerBN/full2/weights/Momentum"
  input: "save/RestoreV2:25"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@LeviHassnerBN/full2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_26"
  op: "Assign"
  input: "OptimizeLoss/learning_rate"
  input: "save/RestoreV2:26"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@OptimizeLoss/learning_rate"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_27"
  op: "Assign"
  input: "OptimizeLoss/output/biases/Momentum"
  input: "save/RestoreV2:27"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_28"
  op: "Assign"
  input: "OptimizeLoss/output/weights/Momentum"
  input: "save/RestoreV2:28"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_29"
  op: "Assign"
  input: "Variable"
  input: "save/RestoreV2:29"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@Variable"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_30"
  op: "Assign"
  input: "add_5/avg"
  input: "save/RestoreV2:30"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@add_5/avg"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_31"
  op: "Assign"
  input: "cross_entropy/avg"
  input: "save/RestoreV2:31"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@cross_entropy/avg"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_32"
  op: "Assign"
  input: "output/biases"
  input: "save/RestoreV2:32"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/biases"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/Assign_33"
  op: "Assign"
  input: "output/weights"
  input: "save/RestoreV2:33"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@output/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/restore_all"
  op: "NoOp"
  input: "^save/Assign"
  input: "^save/Assign_1"
  input: "^save/Assign_10"
  input: "^save/Assign_11"
  input: "^save/Assign_12"
  input: "^save/Assign_13"
  input: "^save/Assign_14"
  input: "^save/Assign_15"
  input: "^save/Assign_16"
  input: "^save/Assign_17"
  input: "^save/Assign_18"
  input: "^save/Assign_19"
  input: "^save/Assign_2"
  input: "^save/Assign_20"
  input: "^save/Assign_21"
  input: "^save/Assign_22"
  input: "^save/Assign_23"
  input: "^save/Assign_24"
  input: "^save/Assign_25"
  input: "^save/Assign_26"
  input: "^save/Assign_27"
  input: "^save/Assign_28"
  input: "^save/Assign_29"
  input: "^save/Assign_3"
  input: "^save/Assign_30"
  input: "^save/Assign_31"
  input: "^save/Assign_32"
  input: "^save/Assign_33"
  input: "^save/Assign_4"
  input: "^save/Assign_5"
  input: "^save/Assign_6"
  input: "^save/Assign_7"
  input: "^save/Assign_8"
  input: "^save/Assign_9"
}
node {
  name: "Merge/MergeSummary"
  op: "MergeSummary"
  input: "batch_processing/input_producer/fraction_of_16_full"
  input: "batch_processing/batch_join/fraction_of_2048_full"
  input: "batch_processing/images"
  input: "tl__raw_"
  input: "cross_entropy__raw_"
  input: "cross_entropy_1"
  input: "add_5__raw_"
  input: "add_5_1"
  input: "OptimizeLoss/learning_rate_1"
  input: "OptimizeLoss/global_norm/gradient_norm"
  input: "OptimizeLoss/loss"
  input: "OptimizeLoss/global_norm/clipped_gradient_norm"
  attr {
    key: "N"
    value {
      i: 12
    }
  }
}
node {
  name: "init"
  op: "NoOp"
  input: "^LeviHassnerBN/conv1/BatchNorm/beta/Assign"
  input: "^LeviHassnerBN/conv1/BatchNorm/moving_mean/Assign"
  input: "^LeviHassnerBN/conv1/BatchNorm/moving_variance/Assign"
  input: "^LeviHassnerBN/conv1/weights/Assign"
  input: "^LeviHassnerBN/conv2/BatchNorm/beta/Assign"
  input: "^LeviHassnerBN/conv2/BatchNorm/moving_mean/Assign"
  input: "^LeviHassnerBN/conv2/BatchNorm/moving_variance/Assign"
  input: "^LeviHassnerBN/conv2/weights/Assign"
  input: "^LeviHassnerBN/conv3/BatchNorm/beta/Assign"
  input: "^LeviHassnerBN/conv3/BatchNorm/moving_mean/Assign"
  input: "^LeviHassnerBN/conv3/BatchNorm/moving_variance/Assign"
  input: "^LeviHassnerBN/conv3/weights/Assign"
  input: "^LeviHassnerBN/full1/biases/Assign"
  input: "^LeviHassnerBN/full1/weights/Assign"
  input: "^LeviHassnerBN/full2/biases/Assign"
  input: "^LeviHassnerBN/full2/weights/Assign"
  input: "^OptimizeLoss/LeviHassnerBN/conv1/BatchNorm/beta/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassnerBN/conv1/weights/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassnerBN/conv2/BatchNorm/beta/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassnerBN/conv2/weights/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassnerBN/conv3/BatchNorm/beta/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassnerBN/conv3/weights/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassnerBN/full1/biases/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassnerBN/full1/weights/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassnerBN/full2/biases/Momentum/Assign"
  input: "^OptimizeLoss/LeviHassnerBN/full2/weights/Momentum/Assign"
  input: "^OptimizeLoss/learning_rate/Assign"
  input: "^OptimizeLoss/output/biases/Momentum/Assign"
  input: "^OptimizeLoss/output/weights/Momentum/Assign"
  input: "^Variable/Assign"
  input: "^add_5/avg/Assign"
  input: "^cross_entropy/avg/Assign"
  input: "^output/biases/Assign"
  input: "^output/weights/Assign"
}
versions {
  producer: 27
}
