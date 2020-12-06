{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -fno-warn-unused-binds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.AutoScaling.DescribeTags
-- Copyright   : (c) 2013-2020 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay+amazonka@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Describes the specified tags.
--
--
-- You can use filters to limit the results. For example, you can query for the tags for a specific Auto Scaling group. You can specify multiple values for a filter. A tag must match at least one of the specified values for it to be included in the results.
--
-- You can also specify multiple filters. The result includes information for a particular tag only if it matches all the filters. If there's no match, no special message is returned.
--
-- For more information, see <https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-tagging.html Tagging Auto Scaling groups and instances> in the /Amazon EC2 Auto Scaling User Guide/ .
--
--
-- This operation returns paginated results.
module Network.AWS.AutoScaling.DescribeTags
  ( -- * Creating a Request
    describeTags,
    DescribeTags,

    -- * Request Lenses
    dtFilters,
    dtNextToken,
    dtMaxRecords,

    -- * Destructuring the Response
    describeTagsResponse,
    DescribeTagsResponse,

    -- * Response Lenses
    dtrsNextToken,
    dtrsTags,
    dtrsResponseStatus,
  )
where

import Network.AWS.AutoScaling.Types
import Network.AWS.Lens
import Network.AWS.Pager
import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Response

-- | /See:/ 'describeTags' smart constructor.
data DescribeTags = DescribeTags'
  { _dtFilters :: !(Maybe [Filter]),
    _dtNextToken :: !(Maybe Text),
    _dtMaxRecords :: !(Maybe Int)
  }
  deriving (Eq, Read, Show, Data, Typeable, Generic)

-- | Creates a value of 'DescribeTags' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'dtFilters' - One or more filters to scope the tags to return. The maximum number of filters per filter type (for example, @auto-scaling-group@ ) is 1000.
--
-- * 'dtNextToken' - The token for the next set of items to return. (You received this token from a previous call.)
--
-- * 'dtMaxRecords' - The maximum number of items to return with this call. The default value is @50@ and the maximum value is @100@ .
describeTags ::
  DescribeTags
describeTags =
  DescribeTags'
    { _dtFilters = Nothing,
      _dtNextToken = Nothing,
      _dtMaxRecords = Nothing
    }

-- | One or more filters to scope the tags to return. The maximum number of filters per filter type (for example, @auto-scaling-group@ ) is 1000.
dtFilters :: Lens' DescribeTags [Filter]
dtFilters = lens _dtFilters (\s a -> s {_dtFilters = a}) . _Default . _Coerce

-- | The token for the next set of items to return. (You received this token from a previous call.)
dtNextToken :: Lens' DescribeTags (Maybe Text)
dtNextToken = lens _dtNextToken (\s a -> s {_dtNextToken = a})

-- | The maximum number of items to return with this call. The default value is @50@ and the maximum value is @100@ .
dtMaxRecords :: Lens' DescribeTags (Maybe Int)
dtMaxRecords = lens _dtMaxRecords (\s a -> s {_dtMaxRecords = a})

instance AWSPager DescribeTags where
  page rq rs
    | stop (rs ^. dtrsNextToken) = Nothing
    | stop (rs ^. dtrsTags) = Nothing
    | otherwise = Just $ rq & dtNextToken .~ rs ^. dtrsNextToken

instance AWSRequest DescribeTags where
  type Rs DescribeTags = DescribeTagsResponse
  request = postQuery autoScaling
  response =
    receiveXMLWrapper
      "DescribeTagsResult"
      ( \s h x ->
          DescribeTagsResponse'
            <$> (x .@? "NextToken")
            <*> (x .@? "Tags" .!@ mempty >>= may (parseXMLList "member"))
            <*> (pure (fromEnum s))
      )

instance Hashable DescribeTags

instance NFData DescribeTags

instance ToHeaders DescribeTags where
  toHeaders = const mempty

instance ToPath DescribeTags where
  toPath = const "/"

instance ToQuery DescribeTags where
  toQuery DescribeTags' {..} =
    mconcat
      [ "Action" =: ("DescribeTags" :: ByteString),
        "Version" =: ("2011-01-01" :: ByteString),
        "Filters" =: toQuery (toQueryList "member" <$> _dtFilters),
        "NextToken" =: _dtNextToken,
        "MaxRecords" =: _dtMaxRecords
      ]

-- | /See:/ 'describeTagsResponse' smart constructor.
data DescribeTagsResponse = DescribeTagsResponse'
  { _dtrsNextToken ::
      !(Maybe Text),
    _dtrsTags :: !(Maybe [TagDescription]),
    _dtrsResponseStatus :: !Int
  }
  deriving (Eq, Read, Show, Data, Typeable, Generic)

-- | Creates a value of 'DescribeTagsResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'dtrsNextToken' - A string that indicates that the response contains more items than can be returned in a single response. To receive additional items, specify this string for the @NextToken@ value when requesting the next set of items. This value is null when there are no more items to return.
--
-- * 'dtrsTags' - One or more tags.
--
-- * 'dtrsResponseStatus' - -- | The response status code.
describeTagsResponse ::
  -- | 'dtrsResponseStatus'
  Int ->
  DescribeTagsResponse
describeTagsResponse pResponseStatus_ =
  DescribeTagsResponse'
    { _dtrsNextToken = Nothing,
      _dtrsTags = Nothing,
      _dtrsResponseStatus = pResponseStatus_
    }

-- | A string that indicates that the response contains more items than can be returned in a single response. To receive additional items, specify this string for the @NextToken@ value when requesting the next set of items. This value is null when there are no more items to return.
dtrsNextToken :: Lens' DescribeTagsResponse (Maybe Text)
dtrsNextToken = lens _dtrsNextToken (\s a -> s {_dtrsNextToken = a})

-- | One or more tags.
dtrsTags :: Lens' DescribeTagsResponse [TagDescription]
dtrsTags = lens _dtrsTags (\s a -> s {_dtrsTags = a}) . _Default . _Coerce

-- | -- | The response status code.
dtrsResponseStatus :: Lens' DescribeTagsResponse Int
dtrsResponseStatus = lens _dtrsResponseStatus (\s a -> s {_dtrsResponseStatus = a})

instance NFData DescribeTagsResponse